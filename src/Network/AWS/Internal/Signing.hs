{-# LANGUAGE DataKinds                  #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE RecordWildCards            #-}
{-# LANGUAGE TupleSections              #-}

-- Module      : Network.AWS.Internal.Signing
-- Copyright   : (c) 2013 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

module Network.AWS.Internal.Signing
    (
    -- * Signing raw requests
      sign

    -- * Exposed for testing purposes
    , SigningMetadata (..)
    , version4
    ) where

import           Control.Applicative
import           Control.Arrow                   ((***), first)
import           Control.Error
import           Control.Monad
import           Control.Monad.IO.Class
import           Data.ByteString                 (ByteString)
import qualified Data.ByteString.Base64          as Base64
import qualified Data.ByteString.Char8           as BS
import qualified Data.ByteString.Lazy            as LBS
import           Data.Char                       (intToDigit, toLower, ord)
import qualified Data.Digest.Pure.SHA            as SHA
import           Data.Function                   (on)
import           Data.List
import           Data.Monoid
import qualified Data.Text.Encoding              as Text
import           Data.Time                       (UTCTime, getCurrentTime)
import           Network.AWS.Internal.HTTP
import           Network.AWS.Internal.String
import           Network.AWS.Internal.Time
import           Network.AWS.Internal.Types
import           Network.HTTP.QueryString.Pickle
import           Network.HTTP.Types              (urlEncode)
import           Network.Http.Client
import           Network.Http.Internal           (retrieveHeaders)

sign :: RawRequest -> AWS SignedRequest
sign r = do
    auth <- getAuth
    reg  <- serviceRegion svc
    time <- liftIO getCurrentTime
    dbg  <- debugEnabled

    let tok  = maybe [] ((:[]) . hdr) $ tokenHeader auth
        host = [hdr $ hostHeader svc reg]
        rq   = r { rqHeaders = concat [rqHeaders r, tok, host] }

    liftIO $ signer dbg rq auth reg time
  where
    svc@Service{..} = rqService r

    signer dbg = case svcSigner of
        SigningVersion2 -> version2
        SigningVersion3 -> version3
        SigningVersion4 -> \a b c d -> fst <$> version4 a b c d dbg

--
-- Internal
--

version2 :: RawRequest
         -> Auth
         -> Region
         -> UTCTime
         -> IO SignedRequest
version2 RawRequest{..} Auth{..} reg time = do
    let url = httpsURL host path
        hs  = hdr (dateHeader $ iso8601Time time) : rqHeaders
    SignedRequest url rqBody <$> createRequest rqMethod path hs
  where
    Service{..} = rqService

    host = endpoint rqService reg
    path = joinPath rqPath $ query <> "&Signature=" <> urlEncode True signature

    query = encodeQuery (urlEncode True) . sort $ rqQuery ++
        [ ("Version",          sPack svcVersion)
        , ("SignatureVersion", "2")
        , ("SignatureMethod",  "HmacSHA256")
        , ("Timestamp",        iso8601Time time)
        , ("AWSAccessKeyId",   accessKeyId)
        ]

    signature = Base64.encode
        . hmac secretAccessKey
        $ BS.intercalate "\n"
            [ BS.pack $ show rqMethod
            , host <> ":443"
            , validPath rqPath
            , query
            ]

version3 :: RawRequest
         -> Auth
         -> Region
         -> UTCTime
         -> IO SignedRequest
version3 RawRequest{..} Auth{..} reg time = do
    let url = httpsURL host path
        hs  = hdr (dateHeader $ rfc822Time time) :
              hdr (authHeader authorization) : rqHeaders
    SignedRequest url rqBody <$> createRequest rqMethod path hs
  where
    Service{..} = rqService

    host = endpoint rqService reg
    path = joinPath rqPath $ encodeQuery (urlEncode True) rqQuery

    authorization = "AWS3-HTTPS AWSAccessKeyId="
        <> accessKeyId
        <> ", Algorithm=HmacSHA256, Signature="
        <> Base64.encode (hmac secretAccessKey $ rfc822Time time)

data SigningMetadata = SigningMetadata
    { smdCReq  :: !ByteString
    , smdSTS   :: !ByteString
    , smdAuthz :: !ByteString
    , smdSReq  :: !ByteString
    } deriving (Eq)

instance Show SigningMetadata where
    show SigningMetadata{..} = BS.unpack . BS.unlines
        $ BS.lines smdCReq
       ++ BS.lines smdSTS
       ++ BS.lines smdAuthz
       ++ BS.lines smdSReq

version4 :: RawRequest
         -> Auth
         -> Region
         -> UTCTime
         -> Bool
         -> IO (SignedRequest, SigningMetadata)
version4 RawRequest{..} Auth{..} reg time dbg = do
    let url = httpsURL (endpoint rqService reg) path
        req = createRequest rqMethod path

    raw <- req $ hdr (dateHeader $ iso8601Time time) : rqHeaders

    let hs   = retrieveHeaders $ getHeadersFull (error "Unable to get connection here") raw
        auth = ("Authorization", " " <> authorization hs time)
        hdrs = auth : hs
        flat = map (\(k, v) -> k <> ":" <> v) hdrs
        info = BS.intercalate " " [method, path, "http/1.1"]
        meta = SigningMetadata (canonicalRequest hs) (stringToSign hs time)
                 (authorization hs time) (BS.unlines $ info : flat)

    when dbg $ print meta

    fmap (, meta) . fmap (SignedRequest url rqBody) . req $ map hdr hdrs
  where
    Service{..} = rqService

    path = joinPath rqPath query

    authorization hdrs ts = mconcat
        [ algorithm
        , " Credential="
        , accessKeyId
        , "/"
        , credentialScope ts
        , ", SignedHeaders="
        , signedHeaders hdrs
        , ", Signature="
        , signature hdrs ts
        ]

    signature hdrs ts = hex . hmac signingKey $ stringToSign hdrs ts
      where
        signingKey = foldl1 hmac
            [ "AWS4" <> secretAccessKey
            , basicTime ts
            , region
            , svcName
            , "aws4_request"
            ]

    stringToSign hdrs ts = BS.intercalate "\n"
        [ algorithm
        , awsTime ts
        , credentialScope ts
        , sha256 $ canonicalRequest hdrs
        ]

    credentialScope ts = BS.intercalate "/"
       [ basicTime ts
       , region
       , svcName
       , "aws4_request"
       ]

    algorithm = "AWS4-HMAC-SHA256"

    canonicalRequest hdrs = BS.intercalate "\n"
        [ method
        , validPath rqPath
        , query
        , canonicalHeaders hdrs
        , signedHeaders hdrs
        , bodySHA256
        ]

    method = BS.pack $ show rqMethod
    region = BS.pack $ show reg

    bodySHA256 = sha256 $
        case rqBody of
            (Strict bs) -> bs
            _           -> ""

    query = encodeQuery (urlEncode True) $ sort rqQuery

    canonicalHeaders = mconcat . map f . headers
      where
        f (k, v) = mconcat [BS.map toLower k, ":", sStripChar ' ' v, "\n"]

    signedHeaders = BS.intercalate ";" . nub . map fst . headers

    headers hdrs = sort
        . map f
        . groupBy ((==) `on` fst)
        $ map (first (BS.map toLower)) hdrs
      where
        f (h:hs) = (BS.map toLower $ fst h, BS.intercalate "," . sort . map snd $ h:hs)
        f []     = ("", "")

createRequest :: Method -> ByteString -> [AnyHeader] -> IO Request
createRequest meth path hs = buildRequest $ do
    http meth path
    setHostname (BS.takeWhile (/= ':') host) 443
    mapM_ (uncurry setHeader) $ filter ((/= "Host") . fst) hdrs
  where
    -- FIXME:
    host = fromMaybe "unknown" $ "Host" `lookup` hdrs
    hdrs = map (join (***) Text.encodeUtf8 . (`encodeHeader` "")) hs

httpsURL :: ByteString -> ByteString -> ByteString
httpsURL host path = "https://" <> sJoin "/" [host, path]

validPath :: ByteString -> ByteString
validPath = sWrap "/"

joinPath :: ByteString -> ByteString -> ByteString
joinPath path qry
    | BS.null qry = validPath path
    | otherwise   = validPath path <> "?" <> qry

hmac :: ByteString -> ByteString -> ByteString
hmac key msg = LBS.toStrict
    . SHA.bytestringDigest
    $ SHA.hmacSha256 (LBS.fromStrict key) (LBS.fromStrict msg)

sha256 :: ByteString -> ByteString
sha256 = hex
    . LBS.toStrict
    . SHA.bytestringDigest
    . SHA.sha256
    . LBS.fromStrict

hex :: ByteString -> ByteString
hex = BS.pack . foldr f "" . BS.unpack
  where
    f c t = intToDigit (n `div` 16) : intToDigit (n `mod` 16) : t
      where
        n = ord c

tokenHeader :: Auth -> Maybe (Header "SecurityToken" ByteString)
tokenHeader = fmap (\t -> Header t) . securityToken

hostHeader :: Service -> Region -> Header "Host" ByteString
hostHeader svc reg = Header $ endpoint svc reg <> ":443"

dateHeader :: ByteString -> Header "Date" ByteString
dateHeader = Header

authHeader :: ByteString -> Header "Authorization" ByteString
authHeader = Header
