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

-- Module      : Network.AWS.CloudFormation.DescribeStackResource
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Returns a description of the specified resource in the specified stack. For
-- deleted stacks, DescribeStackResource returns resource information for up
-- to 90 days after the stack has been deleted.
module Network.AWS.CloudFormation.DescribeStackResource
    (
    -- * Request
      DescribeStackResource
    -- ** Request constructor
    , describeStackResource
    -- ** Request lenses
    , dsr1LogicalResourceId
    , dsr1StackName

    -- * Response
    , DescribeStackResourceResponse
    -- ** Response constructor
    , describeStackResourceResponse
    -- ** Response lenses
    , dsrrStackResourceDetail
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.Query
import Network.AWS.CloudFormation.Types

data DescribeStackResource = DescribeStackResource
    { _dsr1LogicalResourceId :: Text
    , _dsr1StackName         :: Text
    } deriving (Eq, Ord, Show, Generic)

-- | 'DescribeStackResource' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'dsr1LogicalResourceId' @::@ 'Text'
--
-- * 'dsr1StackName' @::@ 'Text'
--
describeStackResource :: Text -- ^ 'dsr1StackName'
                      -> Text -- ^ 'dsr1LogicalResourceId'
                      -> DescribeStackResource
describeStackResource p1 p2 = DescribeStackResource
    { _dsr1StackName         = p1
    , _dsr1LogicalResourceId = p2
    }

-- | The logical name of the resource as specified in the template. Default:
-- There is no default value.
dsr1LogicalResourceId :: Lens' DescribeStackResource Text
dsr1LogicalResourceId =
    lens _dsr1LogicalResourceId (\s a -> s { _dsr1LogicalResourceId = a })

-- | The name or the unique identifier associated with the stack, which are
-- not always interchangeable: Running stacks: You can specify either the
-- stack's name or its unique stack ID. Deleted stacks: You must specify the
-- unique stack ID. Default: There is no default value.
dsr1StackName :: Lens' DescribeStackResource Text
dsr1StackName = lens _dsr1StackName (\s a -> s { _dsr1StackName = a })

instance ToQuery DescribeStackResource

instance ToPath DescribeStackResource where
    toPath = const "/"

newtype DescribeStackResourceResponse = DescribeStackResourceResponse
    { _dsrrStackResourceDetail :: Maybe StackResourceDetail
    } deriving (Eq, Show, Generic)

-- | 'DescribeStackResourceResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'dsrrStackResourceDetail' @::@ 'Maybe' 'StackResourceDetail'
--
describeStackResourceResponse :: DescribeStackResourceResponse
describeStackResourceResponse = DescribeStackResourceResponse
    { _dsrrStackResourceDetail = Nothing
    }

-- | A StackResourceDetail structure containing the description of the
-- specified resource in the specified stack.
dsrrStackResourceDetail :: Lens' DescribeStackResourceResponse (Maybe StackResourceDetail)
dsrrStackResourceDetail =
    lens _dsrrStackResourceDetail (\s a -> s { _dsrrStackResourceDetail = a })

instance FromXML DescribeStackResourceResponse where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "DescribeStackResourceResponse"

instance AWSRequest DescribeStackResource where
    type Sv DescribeStackResource = CloudFormation
    type Rs DescribeStackResource = DescribeStackResourceResponse

    request  = post "DescribeStackResource"
    response = xmlResponse $ \h x -> DescribeStackResourceResponse
        <$> x %| "StackResourceDetail"
