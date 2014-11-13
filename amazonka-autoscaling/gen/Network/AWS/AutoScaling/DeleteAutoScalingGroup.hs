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

-- Module      : Network.AWS.AutoScaling.DeleteAutoScalingGroup
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Deletes the specified Auto Scaling group if the group has no instances and
-- no scaling activities in progress.
module Network.AWS.AutoScaling.DeleteAutoScalingGroup
    (
    -- * Request
      DeleteAutoScalingGroup
    -- ** Request constructor
    , deleteAutoScalingGroup
    -- ** Request lenses
    , dasgAutoScalingGroupName
    , dasgForceDelete

    -- * Response
    , DeleteAutoScalingGroupResponse
    -- ** Response constructor
    , deleteAutoScalingGroupResponse
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.Query
import Network.AWS.AutoScaling.Types

data DeleteAutoScalingGroup = DeleteAutoScalingGroup
    { _dasgAutoScalingGroupName :: Text
    , _dasgForceDelete          :: Maybe Bool
    } deriving (Eq, Ord, Show, Generic)

-- | 'DeleteAutoScalingGroup' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'dasgAutoScalingGroupName' @::@ 'Text'
--
-- * 'dasgForceDelete' @::@ 'Maybe' 'Bool'
--
deleteAutoScalingGroup :: Text -- ^ 'dasgAutoScalingGroupName'
                       -> DeleteAutoScalingGroup
deleteAutoScalingGroup p1 = DeleteAutoScalingGroup
    { _dasgAutoScalingGroupName = p1
    , _dasgForceDelete          = Nothing
    }

-- | The name of the Auto Scaling group to delete.
dasgAutoScalingGroupName :: Lens' DeleteAutoScalingGroup Text
dasgAutoScalingGroupName =
    lens _dasgAutoScalingGroupName
        (\s a -> s { _dasgAutoScalingGroupName = a })

-- | Starting with API version 2011-01-01, specifies that the Auto Scaling
-- group will be deleted along with all instances associated with the group,
-- without waiting for all instances to be terminated. This parameter also
-- deletes any lifecycle actions associated with the group.
dasgForceDelete :: Lens' DeleteAutoScalingGroup (Maybe Bool)
dasgForceDelete = lens _dasgForceDelete (\s a -> s { _dasgForceDelete = a })

instance ToQuery DeleteAutoScalingGroup

instance ToPath DeleteAutoScalingGroup where
    toPath = const "/"

data DeleteAutoScalingGroupResponse = DeleteAutoScalingGroupResponse
    deriving (Eq, Ord, Show, Generic)

-- | 'DeleteAutoScalingGroupResponse' constructor.
deleteAutoScalingGroupResponse :: DeleteAutoScalingGroupResponse
deleteAutoScalingGroupResponse = DeleteAutoScalingGroupResponse

instance FromXML DeleteAutoScalingGroupResponse where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "DeleteAutoScalingGroupResponse"

instance AWSRequest DeleteAutoScalingGroup where
    type Sv DeleteAutoScalingGroup = AutoScaling
    type Rs DeleteAutoScalingGroup = DeleteAutoScalingGroupResponse

    request  = post "DeleteAutoScalingGroup"
    response = nullaryResponse DeleteAutoScalingGroupResponse
