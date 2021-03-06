{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE RecordWildCards    #-}
{-# LANGUAGE TypeFamilies       #-}

{-# OPTIONS_GHC -fno-warn-unused-imports #-}
{-# OPTIONS_GHC -fno-warn-unused-binds   #-}
{-# OPTIONS_GHC -fno-warn-unused-matches #-}

-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- |
-- Module      : Network.AWS.ServiceCatalog.UpdateConstraint
-- Copyright   : (c) 2013-2016 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
--
-- Updates an existing constraint.
--
--
module Network.AWS.ServiceCatalog.UpdateConstraint
    (
    -- * Creating a Request
      updateConstraint
    , UpdateConstraint
    -- * Request Lenses
    , ucAcceptLanguage
    , ucDescription
    , ucId

    -- * Destructuring the Response
    , updateConstraintResponse
    , UpdateConstraintResponse
    -- * Response Lenses
    , ucrsStatus
    , ucrsConstraintDetail
    , ucrsConstraintParameters
    , ucrsResponseStatus
    ) where

import           Network.AWS.Lens
import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response
import           Network.AWS.ServiceCatalog.Types
import           Network.AWS.ServiceCatalog.Types.Product

-- | /See:/ 'updateConstraint' smart constructor.
data UpdateConstraint = UpdateConstraint'
    { _ucAcceptLanguage :: !(Maybe Text)
    , _ucDescription    :: !(Maybe Text)
    , _ucId             :: !Text
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | Creates a value of 'UpdateConstraint' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'ucAcceptLanguage' - The language code to use for this operation. Supported language codes are as follows: "en" (English) "jp" (Japanese) "zh" (Chinese) If no code is specified, "en" is used as the default.
--
-- * 'ucDescription' - The updated text description of the constraint.
--
-- * 'ucId' - The identifier of the constraint to update.
updateConstraint
    :: Text -- ^ 'ucId'
    -> UpdateConstraint
updateConstraint pId_ =
    UpdateConstraint'
    { _ucAcceptLanguage = Nothing
    , _ucDescription = Nothing
    , _ucId = pId_
    }

-- | The language code to use for this operation. Supported language codes are as follows: "en" (English) "jp" (Japanese) "zh" (Chinese) If no code is specified, "en" is used as the default.
ucAcceptLanguage :: Lens' UpdateConstraint (Maybe Text)
ucAcceptLanguage = lens _ucAcceptLanguage (\ s a -> s{_ucAcceptLanguage = a});

-- | The updated text description of the constraint.
ucDescription :: Lens' UpdateConstraint (Maybe Text)
ucDescription = lens _ucDescription (\ s a -> s{_ucDescription = a});

-- | The identifier of the constraint to update.
ucId :: Lens' UpdateConstraint Text
ucId = lens _ucId (\ s a -> s{_ucId = a});

instance AWSRequest UpdateConstraint where
        type Rs UpdateConstraint = UpdateConstraintResponse
        request = postJSON serviceCatalog
        response
          = receiveJSON
              (\ s h x ->
                 UpdateConstraintResponse' <$>
                   (x .?> "Status") <*> (x .?> "ConstraintDetail") <*>
                     (x .?> "ConstraintParameters")
                     <*> (pure (fromEnum s)))

instance Hashable UpdateConstraint

instance NFData UpdateConstraint

instance ToHeaders UpdateConstraint where
        toHeaders
          = const
              (mconcat
                 ["X-Amz-Target" =#
                    ("AWS242ServiceCatalogService.UpdateConstraint" ::
                       ByteString),
                  "Content-Type" =#
                    ("application/x-amz-json-1.1" :: ByteString)])

instance ToJSON UpdateConstraint where
        toJSON UpdateConstraint'{..}
          = object
              (catMaybes
                 [("AcceptLanguage" .=) <$> _ucAcceptLanguage,
                  ("Description" .=) <$> _ucDescription,
                  Just ("Id" .= _ucId)])

instance ToPath UpdateConstraint where
        toPath = const "/"

instance ToQuery UpdateConstraint where
        toQuery = const mempty

-- | /See:/ 'updateConstraintResponse' smart constructor.
data UpdateConstraintResponse = UpdateConstraintResponse'
    { _ucrsStatus               :: !(Maybe RequestStatus)
    , _ucrsConstraintDetail     :: !(Maybe ConstraintDetail)
    , _ucrsConstraintParameters :: !(Maybe Text)
    , _ucrsResponseStatus       :: !Int
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | Creates a value of 'UpdateConstraintResponse' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'ucrsStatus' - The status of the current request.
--
-- * 'ucrsConstraintDetail' - The resulting detailed constraint information.
--
-- * 'ucrsConstraintParameters' - The resulting updated constraint parameters.
--
-- * 'ucrsResponseStatus' - -- | The response status code.
updateConstraintResponse
    :: Int -- ^ 'ucrsResponseStatus'
    -> UpdateConstraintResponse
updateConstraintResponse pResponseStatus_ =
    UpdateConstraintResponse'
    { _ucrsStatus = Nothing
    , _ucrsConstraintDetail = Nothing
    , _ucrsConstraintParameters = Nothing
    , _ucrsResponseStatus = pResponseStatus_
    }

-- | The status of the current request.
ucrsStatus :: Lens' UpdateConstraintResponse (Maybe RequestStatus)
ucrsStatus = lens _ucrsStatus (\ s a -> s{_ucrsStatus = a});

-- | The resulting detailed constraint information.
ucrsConstraintDetail :: Lens' UpdateConstraintResponse (Maybe ConstraintDetail)
ucrsConstraintDetail = lens _ucrsConstraintDetail (\ s a -> s{_ucrsConstraintDetail = a});

-- | The resulting updated constraint parameters.
ucrsConstraintParameters :: Lens' UpdateConstraintResponse (Maybe Text)
ucrsConstraintParameters = lens _ucrsConstraintParameters (\ s a -> s{_ucrsConstraintParameters = a});

-- | -- | The response status code.
ucrsResponseStatus :: Lens' UpdateConstraintResponse Int
ucrsResponseStatus = lens _ucrsResponseStatus (\ s a -> s{_ucrsResponseStatus = a});

instance NFData UpdateConstraintResponse
