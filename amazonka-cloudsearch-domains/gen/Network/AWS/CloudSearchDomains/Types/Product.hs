{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE RecordWildCards    #-}
{-# LANGUAGE TypeFamilies       #-}

{-# OPTIONS_GHC -fno-warn-unused-imports #-}

-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- |
-- Module      : Network.AWS.CloudSearchDomains.Types.Product
-- Copyright   : (c) 2013-2015 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)
--
module Network.AWS.CloudSearchDomains.Types.Product where

import           Network.AWS.CloudSearchDomains.Types.Sum
import           Network.AWS.Prelude

-- | A container for facet information.
--
-- /See:/ 'bucket' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'bucValue'
--
-- * 'bucCount'
data Bucket = Bucket'
    { _bucValue :: !(Maybe Text)
    , _bucCount :: !(Maybe Integer)
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'Bucket' smart constructor.
bucket :: Bucket
bucket =
    Bucket'
    { _bucValue = Nothing
    , _bucCount = Nothing
    }

-- | The facet value being counted.
bucValue :: Lens' Bucket (Maybe Text)
bucValue = lens _bucValue (\ s a -> s{_bucValue = a});

-- | The number of hits that contain the facet value in the specified facet
-- field.
bucCount :: Lens' Bucket (Maybe Integer)
bucCount = lens _bucCount (\ s a -> s{_bucCount = a});

instance FromJSON Bucket where
        parseJSON
          = withObject "Bucket"
              (\ x ->
                 Bucket' <$> (x .:? "value") <*> (x .:? "count"))

-- | A container for the calculated facet values and counts.
--
-- /See:/ 'bucketInfo' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'biBuckets'
newtype BucketInfo = BucketInfo'
    { _biBuckets :: Maybe [Bucket]
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'BucketInfo' smart constructor.
bucketInfo :: BucketInfo
bucketInfo =
    BucketInfo'
    { _biBuckets = Nothing
    }

-- | A list of the calculated facet values and counts.
biBuckets :: Lens' BucketInfo [Bucket]
biBuckets = lens _biBuckets (\ s a -> s{_biBuckets = a}) . _Default;

instance FromJSON BucketInfo where
        parseJSON
          = withObject "BucketInfo"
              (\ x -> BucketInfo' <$> (x .:? "buckets" .!= mempty))

-- | A warning returned by the document service when an issue is discovered
-- while processing an upload request.
--
-- /See:/ 'documentServiceWarning' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'dswMessage'
newtype DocumentServiceWarning = DocumentServiceWarning'
    { _dswMessage :: Maybe Text
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'DocumentServiceWarning' smart constructor.
documentServiceWarning :: DocumentServiceWarning
documentServiceWarning =
    DocumentServiceWarning'
    { _dswMessage = Nothing
    }

-- | The description for a warning returned by the document service.
dswMessage :: Lens' DocumentServiceWarning (Maybe Text)
dswMessage = lens _dswMessage (\ s a -> s{_dswMessage = a});

instance FromJSON DocumentServiceWarning where
        parseJSON
          = withObject "DocumentServiceWarning"
              (\ x ->
                 DocumentServiceWarning' <$> (x .:? "message"))

-- | Information about a document that matches the search request.
--
-- /See:/ 'hit' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'hitExprs'
--
-- * 'hitId'
--
-- * 'hitHighlights'
--
-- * 'hitFields'
data Hit = Hit'
    { _hitExprs      :: !(Maybe (Map Text Text))
    , _hitId         :: !(Maybe Text)
    , _hitHighlights :: !(Maybe (Map Text Text))
    , _hitFields     :: !(Maybe (Map Text [Text]))
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'Hit' smart constructor.
hit :: Hit
hit =
    Hit'
    { _hitExprs = Nothing
    , _hitId = Nothing
    , _hitHighlights = Nothing
    , _hitFields = Nothing
    }

-- | The expressions returned from a document that matches the search
-- request.
hitExprs :: Lens' Hit (HashMap Text Text)
hitExprs = lens _hitExprs (\ s a -> s{_hitExprs = a}) . _Default . _Map;

-- | The document ID of a document that matches the search request.
hitId :: Lens' Hit (Maybe Text)
hitId = lens _hitId (\ s a -> s{_hitId = a});

-- | The highlights returned from a document that matches the search request.
hitHighlights :: Lens' Hit (HashMap Text Text)
hitHighlights = lens _hitHighlights (\ s a -> s{_hitHighlights = a}) . _Default . _Map;

-- | The fields returned from a document that matches the search request.
hitFields :: Lens' Hit (HashMap Text [Text])
hitFields = lens _hitFields (\ s a -> s{_hitFields = a}) . _Default . _Map;

instance FromJSON Hit where
        parseJSON
          = withObject "Hit"
              (\ x ->
                 Hit' <$>
                   (x .:? "exprs" .!= mempty) <*> (x .:? "id") <*>
                     (x .:? "highlights" .!= mempty)
                     <*> (x .:? "fields" .!= mempty))

-- | The collection of documents that match the search request.
--
-- /See:/ 'hits' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'hitCursor'
--
-- * 'hitHit'
--
-- * 'hitStart'
--
-- * 'hitFound'
data Hits = Hits'
    { _hitCursor :: !(Maybe Text)
    , _hitHit    :: !(Maybe [Hit])
    , _hitStart  :: !(Maybe Integer)
    , _hitFound  :: !(Maybe Integer)
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'Hits' smart constructor.
hits :: Hits
hits =
    Hits'
    { _hitCursor = Nothing
    , _hitHit = Nothing
    , _hitStart = Nothing
    , _hitFound = Nothing
    }

-- | A cursor that can be used to retrieve the next set of matching documents
-- when you want to page through a large result set.
hitCursor :: Lens' Hits (Maybe Text)
hitCursor = lens _hitCursor (\ s a -> s{_hitCursor = a});

-- | A document that matches the search request.
hitHit :: Lens' Hits [Hit]
hitHit = lens _hitHit (\ s a -> s{_hitHit = a}) . _Default;

-- | The index of the first matching document.
hitStart :: Lens' Hits (Maybe Integer)
hitStart = lens _hitStart (\ s a -> s{_hitStart = a});

-- | The total number of documents that match the search request.
hitFound :: Lens' Hits (Maybe Integer)
hitFound = lens _hitFound (\ s a -> s{_hitFound = a});

instance FromJSON Hits where
        parseJSON
          = withObject "Hits"
              (\ x ->
                 Hits' <$>
                   (x .:? "cursor") <*> (x .:? "hit" .!= mempty) <*>
                     (x .:? "start")
                     <*> (x .:? "found"))

-- | Contains the resource id (@rid@) and the time it took to process the
-- request (@timems@).
--
-- /See:/ 'searchStatus' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'ssRid'
--
-- * 'ssTimems'
data SearchStatus = SearchStatus'
    { _ssRid    :: !(Maybe Text)
    , _ssTimems :: !(Maybe Integer)
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'SearchStatus' smart constructor.
searchStatus :: SearchStatus
searchStatus =
    SearchStatus'
    { _ssRid = Nothing
    , _ssTimems = Nothing
    }

-- | The encrypted resource ID for the request.
ssRid :: Lens' SearchStatus (Maybe Text)
ssRid = lens _ssRid (\ s a -> s{_ssRid = a});

-- | How long it took to process the request, in milliseconds.
ssTimems :: Lens' SearchStatus (Maybe Integer)
ssTimems = lens _ssTimems (\ s a -> s{_ssTimems = a});

instance FromJSON SearchStatus where
        parseJSON
          = withObject "SearchStatus"
              (\ x ->
                 SearchStatus' <$> (x .:? "rid") <*> (x .:? "timems"))

-- | Container for the suggestion information returned in a
-- @SuggestResponse@.
--
-- /See:/ 'suggestModel' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'smFound'
--
-- * 'smSuggestions'
--
-- * 'smQuery'
data SuggestModel = SuggestModel'
    { _smFound       :: !(Maybe Integer)
    , _smSuggestions :: !(Maybe [SuggestionMatch])
    , _smQuery       :: !(Maybe Text)
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'SuggestModel' smart constructor.
suggestModel :: SuggestModel
suggestModel =
    SuggestModel'
    { _smFound = Nothing
    , _smSuggestions = Nothing
    , _smQuery = Nothing
    }

-- | The number of documents that were found to match the query string.
smFound :: Lens' SuggestModel (Maybe Integer)
smFound = lens _smFound (\ s a -> s{_smFound = a});

-- | The documents that match the query string.
smSuggestions :: Lens' SuggestModel [SuggestionMatch]
smSuggestions = lens _smSuggestions (\ s a -> s{_smSuggestions = a}) . _Default;

-- | The query string specified in the suggest request.
smQuery :: Lens' SuggestModel (Maybe Text)
smQuery = lens _smQuery (\ s a -> s{_smQuery = a});

instance FromJSON SuggestModel where
        parseJSON
          = withObject "SuggestModel"
              (\ x ->
                 SuggestModel' <$>
                   (x .:? "found") <*> (x .:? "suggestions" .!= mempty)
                     <*> (x .:? "query"))

-- | Contains the resource id (@rid@) and the time it took to process the
-- request (@timems@).
--
-- /See:/ 'suggestStatus' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'sugRid'
--
-- * 'sugTimems'
data SuggestStatus = SuggestStatus'
    { _sugRid    :: !(Maybe Text)
    , _sugTimems :: !(Maybe Integer)
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'SuggestStatus' smart constructor.
suggestStatus :: SuggestStatus
suggestStatus =
    SuggestStatus'
    { _sugRid = Nothing
    , _sugTimems = Nothing
    }

-- | The encrypted resource ID for the request.
sugRid :: Lens' SuggestStatus (Maybe Text)
sugRid = lens _sugRid (\ s a -> s{_sugRid = a});

-- | How long it took to process the request, in milliseconds.
sugTimems :: Lens' SuggestStatus (Maybe Integer)
sugTimems = lens _sugTimems (\ s a -> s{_sugTimems = a});

instance FromJSON SuggestStatus where
        parseJSON
          = withObject "SuggestStatus"
              (\ x ->
                 SuggestStatus' <$>
                   (x .:? "rid") <*> (x .:? "timems"))

-- | An autocomplete suggestion that matches the query string specified in a
-- @SuggestRequest@.
--
-- /See:/ 'suggestionMatch' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'smSuggestion'
--
-- * 'smScore'
--
-- * 'smId'
data SuggestionMatch = SuggestionMatch'
    { _smSuggestion :: !(Maybe Text)
    , _smScore      :: !(Maybe Integer)
    , _smId         :: !(Maybe Text)
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'SuggestionMatch' smart constructor.
suggestionMatch :: SuggestionMatch
suggestionMatch =
    SuggestionMatch'
    { _smSuggestion = Nothing
    , _smScore = Nothing
    , _smId = Nothing
    }

-- | The string that matches the query string specified in the
-- @SuggestRequest@.
smSuggestion :: Lens' SuggestionMatch (Maybe Text)
smSuggestion = lens _smSuggestion (\ s a -> s{_smSuggestion = a});

-- | The relevance score of a suggested match.
smScore :: Lens' SuggestionMatch (Maybe Integer)
smScore = lens _smScore (\ s a -> s{_smScore = a});

-- | The document ID of the suggested document.
smId :: Lens' SuggestionMatch (Maybe Text)
smId = lens _smId (\ s a -> s{_smId = a});

instance FromJSON SuggestionMatch where
        parseJSON
          = withObject "SuggestionMatch"
              (\ x ->
                 SuggestionMatch' <$>
                   (x .:? "suggestion") <*> (x .:? "score") <*>
                     (x .:? "id"))
