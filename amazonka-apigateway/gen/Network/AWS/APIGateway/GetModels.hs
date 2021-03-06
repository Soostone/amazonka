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
-- Module      : Network.AWS.APIGateway.GetModels
-- Copyright   : (c) 2013-2015 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
--
-- Describes existing Models defined for a RestApi resource.
--
-- /See:/ <http://docs.aws.amazon.com/apigateway/api-reference/resource/GetModels.html AWS API Reference> for GetModels.
--
-- This operation returns paginated results.
module Network.AWS.APIGateway.GetModels
    (
    -- * Creating a Request
      getModels
    , GetModels
    -- * Request Lenses
    , gmsLimit
    , gmsPosition
    , gmsRestAPIId

    -- * Destructuring the Response
    , getModelsResponse
    , GetModelsResponse
    -- * Response Lenses
    , gmrsItems
    , gmrsPosition
    , gmrsResponseStatus
    ) where

import           Network.AWS.APIGateway.Types
import           Network.AWS.APIGateway.Types.Product
import           Network.AWS.Pager
import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response

-- | Request to list existing Models defined for a RestApi resource.
--
-- /See:/ 'getModels' smart constructor.
data GetModels = GetModels'
    { _gmsLimit     :: !(Maybe Int)
    , _gmsPosition  :: !(Maybe Text)
    , _gmsRestAPIId :: !Text
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | Creates a value of 'GetModels' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'gmsLimit'
--
-- * 'gmsPosition'
--
-- * 'gmsRestAPIId'
getModels
    :: Text -- ^ 'gmsRestAPIId'
    -> GetModels
getModels pRestAPIId_ =
    GetModels'
    { _gmsLimit = Nothing
    , _gmsPosition = Nothing
    , _gmsRestAPIId = pRestAPIId_
    }

-- | The maximum number of models in the collection to get information about.
-- The default limit is 25. It should be an integer between 1 - 500.
gmsLimit :: Lens' GetModels (Maybe Int)
gmsLimit = lens _gmsLimit (\ s a -> s{_gmsLimit = a});

-- | The position of the next set of results in the Models resource to get
-- information about.
gmsPosition :: Lens' GetModels (Maybe Text)
gmsPosition = lens _gmsPosition (\ s a -> s{_gmsPosition = a});

-- | The RestApi identifier.
gmsRestAPIId :: Lens' GetModels Text
gmsRestAPIId = lens _gmsRestAPIId (\ s a -> s{_gmsRestAPIId = a});

instance AWSPager GetModels where
        page rq rs
          | stop (rs ^. gmrsPosition) = Nothing
          | stop (rs ^. gmrsItems) = Nothing
          | otherwise =
            Just $ rq & gmsPosition .~ rs ^. gmrsPosition

instance AWSRequest GetModels where
        type Rs GetModels = GetModelsResponse
        request = get aPIGateway
        response
          = receiveJSON
              (\ s h x ->
                 GetModelsResponse' <$>
                   (x .?> "item" .!@ mempty) <*> (x .?> "position") <*>
                     (pure (fromEnum s)))

instance ToHeaders GetModels where
        toHeaders = const mempty

instance ToPath GetModels where
        toPath GetModels'{..}
          = mconcat
              ["/restapis/", toBS _gmsRestAPIId, "/models"]

instance ToQuery GetModels where
        toQuery GetModels'{..}
          = mconcat
              ["limit" =: _gmsLimit, "position" =: _gmsPosition]

-- | Represents a collection of Model resources.
--
-- /See:/ 'getModelsResponse' smart constructor.
data GetModelsResponse = GetModelsResponse'
    { _gmrsItems          :: !(Maybe [Model])
    , _gmrsPosition       :: !(Maybe Text)
    , _gmrsResponseStatus :: !Int
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | Creates a value of 'GetModelsResponse' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'gmrsItems'
--
-- * 'gmrsPosition'
--
-- * 'gmrsResponseStatus'
getModelsResponse
    :: Int -- ^ 'gmrsResponseStatus'
    -> GetModelsResponse
getModelsResponse pResponseStatus_ =
    GetModelsResponse'
    { _gmrsItems = Nothing
    , _gmrsPosition = Nothing
    , _gmrsResponseStatus = pResponseStatus_
    }

-- | Gets the current Model resource in the collection.
gmrsItems :: Lens' GetModelsResponse [Model]
gmrsItems = lens _gmrsItems (\ s a -> s{_gmrsItems = a}) . _Default . _Coerce;

-- | Undocumented member.
gmrsPosition :: Lens' GetModelsResponse (Maybe Text)
gmrsPosition = lens _gmrsPosition (\ s a -> s{_gmrsPosition = a});

-- | The response status code.
gmrsResponseStatus :: Lens' GetModelsResponse Int
gmrsResponseStatus = lens _gmrsResponseStatus (\ s a -> s{_gmrsResponseStatus = a});
