{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE NoImplicitPrelude          #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE RecordWildCards            #-}
{-# LANGUAGE TypeFamilies               #-}

-- {-# OPTIONS_GHC -fno-warn-unused-imports #-}
-- {-# OPTIONS_GHC -fno-warn-unused-binds  #-} doesnt work if wall is used
{-# OPTIONS_GHC -w #-}

-- Module      : Network.AWS.ElasticBeanstalk.DeleteApplicationVersion
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Deletes the specified version from the specified application.
module Network.AWS.ElasticBeanstalk.DeleteApplicationVersion
    (
    -- * Request
      DeleteApplicationVersion
    -- ** Request constructor
    , deleteApplicationVersion
    -- ** Request lenses
    , davApplicationName
    , davDeleteSourceBundle
    , davVersionLabel

    -- * Response
    , DeleteApplicationVersionResponse
    -- ** Response constructor
    , deleteApplicationVersionResponse
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.Query
import Network.AWS.ElasticBeanstalk.Types

data DeleteApplicationVersion = DeleteApplicationVersion
    { _davApplicationName    :: Text
    , _davDeleteSourceBundle :: Maybe Bool
    , _davVersionLabel       :: Text
    } deriving (Eq, Ord, Show, Generic)

-- | 'DeleteApplicationVersion' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'davApplicationName' @::@ 'Text'
--
-- * 'davDeleteSourceBundle' @::@ 'Maybe' 'Bool'
--
-- * 'davVersionLabel' @::@ 'Text'
--
deleteApplicationVersion :: Text -- ^ 'davApplicationName'
                         -> Text -- ^ 'davVersionLabel'
                         -> DeleteApplicationVersion
deleteApplicationVersion p1 p2 = DeleteApplicationVersion
    { _davApplicationName    = p1
    , _davVersionLabel       = p2
    , _davDeleteSourceBundle = Nothing
    }

-- | The name of the application to delete releases from.
davApplicationName :: Lens' DeleteApplicationVersion Text
davApplicationName =
    lens _davApplicationName (\s a -> s { _davApplicationName = a })

-- | Indicates whether to delete the associated source bundle from Amazon S3:
-- true: An attempt is made to delete the associated Amazon S3 source bundle
-- specified at time of creation. false: No action is taken on the Amazon S3
-- source bundle specified at time of creation. Valid Values: true | false.
davDeleteSourceBundle :: Lens' DeleteApplicationVersion (Maybe Bool)
davDeleteSourceBundle =
    lens _davDeleteSourceBundle (\s a -> s { _davDeleteSourceBundle = a })

-- | The label of the version to delete.
davVersionLabel :: Lens' DeleteApplicationVersion Text
davVersionLabel = lens _davVersionLabel (\s a -> s { _davVersionLabel = a })

instance ToQuery DeleteApplicationVersion

instance ToPath DeleteApplicationVersion where
    toPath = const "/"

data DeleteApplicationVersionResponse = DeleteApplicationVersionResponse
    deriving (Eq, Ord, Show, Generic)

-- | 'DeleteApplicationVersionResponse' constructor.
deleteApplicationVersionResponse :: DeleteApplicationVersionResponse
deleteApplicationVersionResponse = DeleteApplicationVersionResponse

instance FromXML DeleteApplicationVersionResponse where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "DeleteApplicationVersionResponse"

instance AWSRequest DeleteApplicationVersion where
    type Sv DeleteApplicationVersion = ElasticBeanstalk
    type Rs DeleteApplicationVersion = DeleteApplicationVersionResponse

    request  = post "DeleteApplicationVersion"
    response = nullaryResponse DeleteApplicationVersionResponse
