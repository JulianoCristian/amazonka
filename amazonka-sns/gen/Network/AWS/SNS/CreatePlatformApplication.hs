{-# LANGUAGE DeriveGeneric               #-}
{-# LANGUAGE FlexibleInstances           #-}
{-# LANGUAGE NoImplicitPrelude           #-}
{-# LANGUAGE OverloadedStrings           #-}
{-# LANGUAGE RecordWildCards             #-}
{-# LANGUAGE TypeFamilies                #-}

{-# OPTIONS_GHC -fno-warn-unused-imports #-}

-- Module      : Network.AWS.SNS.CreatePlatformApplication
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Creates a platform application object for one of the supported push
-- notification services, such as APNS and GCM, to which devices and mobile
-- apps may register. You must specify PlatformPrincipal and
-- PlatformCredential attributes when using the CreatePlatformApplication
-- action. The PlatformPrincipal is received from the notification service.
-- For APNS/APNS_SANDBOX, PlatformPrincipal is "SSL certificate". For GCM,
-- PlatformPrincipal is not applicable. For ADM, PlatformPrincipal is "client
-- id". The PlatformCredential is also received from the notification service.
-- For APNS/APNS_SANDBOX, PlatformCredential is "private key". For GCM,
-- PlatformCredential is "API key". For ADM, PlatformCredential is "client
-- secret". The PlatformApplicationArn that is returned when using
-- CreatePlatformApplication is then used as an attribute for the
-- CreatePlatformEndpoint action. For more information, see Using Amazon SNS
-- Mobile Push Notifications. POST http://sns.us-west-2.amazonaws.com/
-- HTTP/1.1 ... Attributes.entry.2.key=PlatformPrincipal
-- &amp;SignatureMethod=HmacSHA256
-- &amp;Attributes.entry.1.value=AIzaSyClE2lcV2zEKTLYYo645zfk2jhQPFeyxDo
-- &amp;Attributes.entry.2.value=There+is+no+principal+for+GCM
-- &amp;AWSAccessKeyId=AKIAIOSFODNN7EXAMPLE
-- &amp;Signature=82sHzg1Wfbgisw3i%2BHA2OgBmRktsqUKFinknkq3u%2FQ4%3D
-- &amp;Timestamp=2013-07-01T15%3A49%3A50.354Z &amp;Name=gcmpushapp
-- &amp;Attributes.entry.1.key=PlatformCredential
-- &amp;Action=CreatePlatformApplication &amp;Version=2010-03-31
-- &amp;SignatureVersion=2 &amp;Platform=GCM HTTP/1.1 200 OK ...
-- &lt;CreatePlatformApplicationResponse
-- xmlns="http://sns.amazonaws.com/doc/2010-03-31/"&gt;
-- &lt;CreatePlatformApplicationResult&gt;
-- &lt;PlatformApplicationArn&gt;arn:aws:sns:us-west-2:123456789012:app/GCM/gcmpushapp&lt;/PlatformApplicationArn&gt;
-- &lt;/CreatePlatformApplicationResult&gt; &lt;ResponseMetadata&gt;
-- &lt;RequestId&gt;b6f0e78b-e9d4-5a0e-b973-adc04e8a4ff9&lt;/RequestId&gt;
-- &lt;/ResponseMetadata&gt; &lt;/CreatePlatformApplicationResponse&gt;.
module Network.AWS.SNS.CreatePlatformApplication
    (
    -- * Request
      CreatePlatformApplication
    -- ** Request constructor
    , mkCreatePlatformApplication
    -- ** Request lenses
    , cpaName
    , cpaPlatform
    , cpaAttributes

    -- * Response
    , CreatePlatformApplicationResponse
    -- ** Response constructor
    , mkCreatePlatformApplicationResponse
    -- ** Response lenses
    , cparPlatformApplicationArn
    ) where

import Network.AWS.Request.Query
import Network.AWS.SNS.Types
import Network.AWS.Prelude

-- | Input for CreatePlatformApplication action.
data CreatePlatformApplication = CreatePlatformApplication
    { _cpaName :: !Text
    , _cpaPlatform :: !Text
    , _cpaAttributes :: Map Text Text
    } deriving (Show, Generic)

-- | Smart constructor for the minimum required parameters to construct
-- a valid 'CreatePlatformApplication' request.
--
-- The fields accessible through corresponding lenses are:
--
-- * @Name ::@ @Text@
--
-- * @Platform ::@ @Text@
--
-- * @Attributes ::@ @Map Text Text@
--
mkCreatePlatformApplication :: Text -- ^ 'cpaName'
                            -> Text -- ^ 'cpaPlatform'
                            -> Map Text Text -- ^ 'cpaAttributes'
                            -> CreatePlatformApplication
mkCreatePlatformApplication p1 p2 p3 = CreatePlatformApplication
    { _cpaName = p1
    , _cpaPlatform = p2
    , _cpaAttributes = p3
    }

-- | Application names must be made up of only uppercase and lowercase ASCII
-- letters, numbers, underscores, hyphens, and periods, and must be between 1
-- and 256 characters long.
cpaName :: Lens' CreatePlatformApplication Text
cpaName = lens _cpaName (\s a -> s { _cpaName = a })

-- | The following platforms are supported: ADM (Amazon Device Messaging), APNS
-- (Apple Push Notification Service), APNS_SANDBOX, and GCM (Google Cloud
-- Messaging).
cpaPlatform :: Lens' CreatePlatformApplication Text
cpaPlatform = lens _cpaPlatform (\s a -> s { _cpaPlatform = a })

-- | For a list of attributes, see SetPlatformApplicationAttributes.
cpaAttributes :: Lens' CreatePlatformApplication (Map Text Text)
cpaAttributes = lens _cpaAttributes (\s a -> s { _cpaAttributes = a })

instance ToQuery CreatePlatformApplication where
    toQuery = genericQuery def

-- | Response from CreatePlatformApplication action.
newtype CreatePlatformApplicationResponse = CreatePlatformApplicationResponse
    { _cparPlatformApplicationArn :: Maybe Text
    } deriving (Show, Generic)

-- | Smart constructor for the minimum required parameters to construct
-- a valid 'CreatePlatformApplicationResponse' response.
--
-- This constructor is provided for convenience and testing purposes.
--
-- The fields accessible through corresponding lenses are:
--
-- * @PlatformApplicationArn ::@ @Maybe Text@
--
mkCreatePlatformApplicationResponse :: CreatePlatformApplicationResponse
mkCreatePlatformApplicationResponse = CreatePlatformApplicationResponse
    { _cparPlatformApplicationArn = Nothing
    }

-- | PlatformApplicationArn is returned.
cparPlatformApplicationArn :: Lens' CreatePlatformApplicationResponse (Maybe Text)
cparPlatformApplicationArn =
    lens _cparPlatformApplicationArn
         (\s a -> s { _cparPlatformApplicationArn = a })

instance FromXML CreatePlatformApplicationResponse where
    fromXMLOptions = xmlOptions

instance AWSRequest CreatePlatformApplication where
    type Sv CreatePlatformApplication = SNS
    type Rs CreatePlatformApplication = CreatePlatformApplicationResponse

    request = post "CreatePlatformApplication"
    response _ = xmlResponse
