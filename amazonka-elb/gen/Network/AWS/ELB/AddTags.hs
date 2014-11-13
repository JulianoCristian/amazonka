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

-- Module      : Network.AWS.ELB.AddTags
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Adds one or more tags for the specified load balancer. Each load balancer
-- can have a maximum of 10 tags. Each tag consists of a key and an optional
-- value. Tag keys must be unique for each load balancer. If a tag with the
-- same key is already associated with the load balancer, this action will
-- update the value of the key. For more information, see Tagging in the
-- Elastic Load Balancing Developer Guide.
module Network.AWS.ELB.AddTags
    (
    -- * Request
      AddTags
    -- ** Request constructor
    , addTags
    -- ** Request lenses
    , atLoadBalancerNames
    , atTags

    -- * Response
    , AddTagsResponse
    -- ** Response constructor
    , addTagsResponse
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.Query
import Network.AWS.ELB.Types

data AddTags = AddTags
    { _atLoadBalancerNames :: [Text]
    , _atTags              :: List1 Tag
    } deriving (Eq, Show, Generic)

-- | 'AddTags' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'atLoadBalancerNames' @::@ ['Text']
--
-- * 'atTags' @::@ 'NonEmpty' 'Tag'
--
addTags :: NonEmpty Tag -- ^ 'atTags'
        -> AddTags
addTags p1 = AddTags
    { _atTags              = withIso _List1 (const id) p1
    , _atLoadBalancerNames = mempty
    }

-- | The name of the load balancer to tag. You can specify a maximum of one
-- load balancer name.
atLoadBalancerNames :: Lens' AddTags [Text]
atLoadBalancerNames =
    lens _atLoadBalancerNames (\s a -> s { _atLoadBalancerNames = a })

-- | A list of tags for each load balancer.
atTags :: Lens' AddTags (NonEmpty Tag)
atTags = lens _atTags (\s a -> s { _atTags = a })
    . _List1

instance ToQuery AddTags

instance ToPath AddTags where
    toPath = const "/"

data AddTagsResponse = AddTagsResponse
    deriving (Eq, Ord, Show, Generic)

-- | 'AddTagsResponse' constructor.
addTagsResponse :: AddTagsResponse
addTagsResponse = AddTagsResponse

instance FromXML AddTagsResponse where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "AddTagsResponse"

instance AWSRequest AddTags where
    type Sv AddTags = ELB
    type Rs AddTags = AddTagsResponse

    request  = post "AddTags"
    response = nullaryResponse AddTagsResponse
