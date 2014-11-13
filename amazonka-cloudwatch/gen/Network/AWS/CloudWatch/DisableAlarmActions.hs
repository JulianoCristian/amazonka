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

-- Module      : Network.AWS.CloudWatch.DisableAlarmActions
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Disables actions for the specified alarms. When an alarm's actions are
-- disabled the alarm's state may change, but none of the alarm's actions will
-- execute.
module Network.AWS.CloudWatch.DisableAlarmActions
    (
    -- * Request
      DisableAlarmActions
    -- ** Request constructor
    , disableAlarmActions
    -- ** Request lenses
    , daaAlarmNames

    -- * Response
    , DisableAlarmActionsResponse
    -- ** Response constructor
    , disableAlarmActionsResponse
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.Query
import Network.AWS.CloudWatch.Types

newtype DisableAlarmActions = DisableAlarmActions
    { _daaAlarmNames :: [Text]
    } deriving (Eq, Ord, Show, Generic, Monoid, Semigroup)

instance IsList DisableAlarmActions where
    type Item DisableAlarmActions = Text

    fromList = DisableAlarmActions . fromList
    toList   = toList . _daaAlarmNames

-- | 'DisableAlarmActions' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'daaAlarmNames' @::@ ['Text']
--
disableAlarmActions :: DisableAlarmActions
disableAlarmActions = DisableAlarmActions
    { _daaAlarmNames = mempty
    }

-- | The names of the alarms to disable actions for.
daaAlarmNames :: Lens' DisableAlarmActions [Text]
daaAlarmNames = lens _daaAlarmNames (\s a -> s { _daaAlarmNames = a })

instance ToQuery DisableAlarmActions

instance ToPath DisableAlarmActions where
    toPath = const "/"

data DisableAlarmActionsResponse = DisableAlarmActionsResponse
    deriving (Eq, Ord, Show, Generic)

-- | 'DisableAlarmActionsResponse' constructor.
disableAlarmActionsResponse :: DisableAlarmActionsResponse
disableAlarmActionsResponse = DisableAlarmActionsResponse

instance FromXML DisableAlarmActionsResponse where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "DisableAlarmActionsResponse"

instance AWSRequest DisableAlarmActions where
    type Sv DisableAlarmActions = CloudWatch
    type Rs DisableAlarmActions = DisableAlarmActionsResponse

    request  = post "DisableAlarmActions"
    response = nullaryResponse DisableAlarmActionsResponse
