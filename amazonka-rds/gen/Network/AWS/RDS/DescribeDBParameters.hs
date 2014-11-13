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

-- Module      : Network.AWS.RDS.DescribeDBParameters
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Returns the detailed parameter list for a particular DB parameter group.
module Network.AWS.RDS.DescribeDBParameters
    (
    -- * Request
      DescribeDBParameters
    -- ** Request constructor
    , describeDBParameters
    -- ** Request lenses
    , ddbpDBParameterGroupName
    , ddbpFilters
    , ddbpMarker
    , ddbpMaxRecords
    , ddbpSource

    -- * Response
    , DescribeDBParametersResponse
    -- ** Response constructor
    , describeDBParametersResponse
    -- ** Response lenses
    , ddbprMarker
    , ddbprParameters
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.Query
import Network.AWS.RDS.Types

data DescribeDBParameters = DescribeDBParameters
    { _ddbpDBParameterGroupName :: Text
    , _ddbpFilters              :: [Filter]
    , _ddbpMarker               :: Maybe Text
    , _ddbpMaxRecords           :: Maybe Int
    , _ddbpSource               :: Maybe Text
    } deriving (Eq, Show, Generic)

-- | 'DescribeDBParameters' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'ddbpDBParameterGroupName' @::@ 'Text'
--
-- * 'ddbpFilters' @::@ ['Filter']
--
-- * 'ddbpMarker' @::@ 'Maybe' 'Text'
--
-- * 'ddbpMaxRecords' @::@ 'Maybe' 'Int'
--
-- * 'ddbpSource' @::@ 'Maybe' 'Text'
--
describeDBParameters :: Text -- ^ 'ddbpDBParameterGroupName'
                     -> DescribeDBParameters
describeDBParameters p1 = DescribeDBParameters
    { _ddbpDBParameterGroupName = p1
    , _ddbpSource               = Nothing
    , _ddbpFilters              = mempty
    , _ddbpMaxRecords           = Nothing
    , _ddbpMarker               = Nothing
    }

-- | The name of a specific DB parameter group to return details for.
-- Constraints: Must be 1 to 255 alphanumeric characters First character
-- must be a letter Cannot end with a hyphen or contain two consecutive
-- hyphens.
ddbpDBParameterGroupName :: Lens' DescribeDBParameters Text
ddbpDBParameterGroupName =
    lens _ddbpDBParameterGroupName
        (\s a -> s { _ddbpDBParameterGroupName = a })

-- | This parameter is not currently supported.
ddbpFilters :: Lens' DescribeDBParameters [Filter]
ddbpFilters = lens _ddbpFilters (\s a -> s { _ddbpFilters = a })

-- | An optional pagination token provided by a previous DescribeDBParameters
-- request. If this parameter is specified, the response includes only
-- records beyond the marker, up to the value specified by MaxRecords.
ddbpMarker :: Lens' DescribeDBParameters (Maybe Text)
ddbpMarker = lens _ddbpMarker (\s a -> s { _ddbpMarker = a })

-- | The maximum number of records to include in the response. If more records
-- exist than the specified MaxRecords value, a pagination token called a
-- marker is included in the response so that the remaining results may be
-- retrieved. Default: 100 Constraints: minimum 20, maximum 100.
ddbpMaxRecords :: Lens' DescribeDBParameters (Maybe Int)
ddbpMaxRecords = lens _ddbpMaxRecords (\s a -> s { _ddbpMaxRecords = a })

-- | The parameter types to return. Default: All parameter types returned
-- Valid Values: user | system | engine-default.
ddbpSource :: Lens' DescribeDBParameters (Maybe Text)
ddbpSource = lens _ddbpSource (\s a -> s { _ddbpSource = a })

instance ToQuery DescribeDBParameters

instance ToPath DescribeDBParameters where
    toPath = const "/"

data DescribeDBParametersResponse = DescribeDBParametersResponse
    { _ddbprMarker     :: Maybe Text
    , _ddbprParameters :: [Parameter]
    } deriving (Eq, Show, Generic)

-- | 'DescribeDBParametersResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'ddbprMarker' @::@ 'Maybe' 'Text'
--
-- * 'ddbprParameters' @::@ ['Parameter']
--
describeDBParametersResponse :: DescribeDBParametersResponse
describeDBParametersResponse = DescribeDBParametersResponse
    { _ddbprParameters = mempty
    , _ddbprMarker     = Nothing
    }

-- | An optional pagination token provided by a previous request. If this
-- parameter is specified, the response includes only records beyond the
-- marker, up to the value specified by MaxRecords.
ddbprMarker :: Lens' DescribeDBParametersResponse (Maybe Text)
ddbprMarker = lens _ddbprMarker (\s a -> s { _ddbprMarker = a })

-- | A list of Parameter values.
ddbprParameters :: Lens' DescribeDBParametersResponse [Parameter]
ddbprParameters = lens _ddbprParameters (\s a -> s { _ddbprParameters = a })

instance FromXML DescribeDBParametersResponse where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "DescribeDBParametersResponse"

instance AWSRequest DescribeDBParameters where
    type Sv DescribeDBParameters = RDS
    type Rs DescribeDBParameters = DescribeDBParametersResponse

    request  = post "DescribeDBParameters"
    response = xmlResponse $ \h x -> DescribeDBParametersResponse
        <$> x %| "Marker"
        <*> x %| "Parameters"
