{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE RecordWildCards    #-}
{-# LANGUAGE TypeFamilies       #-}

-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- |
-- Module      : Network.AWS.ECS.ListContainerInstances
-- Copyright   : (c) 2013-2015 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)
--
-- Returns a list of container instances in a specified cluster.
--
-- <http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ListContainerInstances.html>
module Network.AWS.ECS.ListContainerInstances
    (
    -- * Request
      ListContainerInstances
    -- ** Request constructor
    , listContainerInstances
    -- ** Request lenses
    , lciCluster
    , lciNextToken
    , lciMaxResults

    -- * Response
    , ListContainerInstancesResponse
    -- ** Response constructor
    , listContainerInstancesResponse
    -- ** Response lenses
    , lcirContainerInstanceARNs
    , lcirNextToken
    , lcirStatus
    ) where

import           Network.AWS.ECS.Types
import           Network.AWS.Pager
import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response

-- | /See:/ 'listContainerInstances' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'lciCluster'
--
-- * 'lciNextToken'
--
-- * 'lciMaxResults'
data ListContainerInstances = ListContainerInstances'
    { _lciCluster    :: !(Maybe Text)
    , _lciNextToken  :: !(Maybe Text)
    , _lciMaxResults :: !(Maybe Int)
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'ListContainerInstances' smart constructor.
listContainerInstances :: ListContainerInstances
listContainerInstances =
    ListContainerInstances'
    { _lciCluster = Nothing
    , _lciNextToken = Nothing
    , _lciMaxResults = Nothing
    }

-- | The short name or full Amazon Resource Name (ARN) of the cluster that
-- hosts the container instances you want to list. If you do not specify a
-- cluster, the default cluster is assumed..
lciCluster :: Lens' ListContainerInstances (Maybe Text)
lciCluster = lens _lciCluster (\ s a -> s{_lciCluster = a});

-- | The @nextToken@ value returned from a previous paginated
-- @ListContainerInstances@ request where @maxResults@ was used and the
-- results exceeded the value of that parameter. Pagination continues from
-- the end of the previous results that returned the @nextToken@ value.
-- This value is @null@ when there are no more results to return.
lciNextToken :: Lens' ListContainerInstances (Maybe Text)
lciNextToken = lens _lciNextToken (\ s a -> s{_lciNextToken = a});

-- | The maximum number of container instance results returned by
-- @ListContainerInstances@ in paginated output. When this parameter is
-- used, @ListContainerInstances@ only returns @maxResults@ results in a
-- single page along with a @nextToken@ response element. The remaining
-- results of the initial request can be seen by sending another
-- @ListContainerInstances@ request with the returned @nextToken@ value.
-- This value can be between 1 and 100. If this parameter is not used, then
-- @ListContainerInstances@ returns up to 100 results and a @nextToken@
-- value if applicable.
lciMaxResults :: Lens' ListContainerInstances (Maybe Int)
lciMaxResults = lens _lciMaxResults (\ s a -> s{_lciMaxResults = a});

instance AWSPager ListContainerInstances where
        page rq rs
          | stop (rs ^. lcirNextToken) = Nothing
          | stop (rs ^. lcirContainerInstanceARNs) = Nothing
          | otherwise =
            Just $ rq & lciNextToken .~ rs ^. lcirNextToken

instance AWSRequest ListContainerInstances where
        type Sv ListContainerInstances = ECS
        type Rs ListContainerInstances =
             ListContainerInstancesResponse
        request = postJSON
        response
          = receiveJSON
              (\ s h x ->
                 ListContainerInstancesResponse' <$>
                   (x .?> "containerInstanceArns" .!@ mempty) <*>
                     (x .?> "nextToken")
                     <*> (pure (fromEnum s)))

instance ToHeaders ListContainerInstances where
        toHeaders
          = const
              (mconcat
                 ["X-Amz-Target" =#
                    ("AmazonEC2ContainerServiceV20141113.ListContainerInstances"
                       :: ByteString),
                  "Content-Type" =#
                    ("application/x-amz-json-1.1" :: ByteString)])

instance ToJSON ListContainerInstances where
        toJSON ListContainerInstances'{..}
          = object
              ["cluster" .= _lciCluster,
               "nextToken" .= _lciNextToken,
               "maxResults" .= _lciMaxResults]

instance ToPath ListContainerInstances where
        toPath = const "/"

instance ToQuery ListContainerInstances where
        toQuery = const mempty

-- | /See:/ 'listContainerInstancesResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'lcirContainerInstanceARNs'
--
-- * 'lcirNextToken'
--
-- * 'lcirStatus'
data ListContainerInstancesResponse = ListContainerInstancesResponse'
    { _lcirContainerInstanceARNs :: !(Maybe [Text])
    , _lcirNextToken             :: !(Maybe Text)
    , _lcirStatus                :: !Int
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'ListContainerInstancesResponse' smart constructor.
listContainerInstancesResponse :: Int -> ListContainerInstancesResponse
listContainerInstancesResponse pStatus =
    ListContainerInstancesResponse'
    { _lcirContainerInstanceARNs = Nothing
    , _lcirNextToken = Nothing
    , _lcirStatus = pStatus
    }

-- | The list of container instance full Amazon Resource Name (ARN) entries
-- for each container instance associated with the specified cluster.
lcirContainerInstanceARNs :: Lens' ListContainerInstancesResponse [Text]
lcirContainerInstanceARNs = lens _lcirContainerInstanceARNs (\ s a -> s{_lcirContainerInstanceARNs = a}) . _Default;

-- | The @nextToken@ value to include in a future @ListContainerInstances@
-- request. When the results of a @ListContainerInstances@ request exceed
-- @maxResults@, this value can be used to retrieve the next page of
-- results. This value is @null@ when there are no more results to return.
lcirNextToken :: Lens' ListContainerInstancesResponse (Maybe Text)
lcirNextToken = lens _lcirNextToken (\ s a -> s{_lcirNextToken = a});

-- | FIXME: Undocumented member.
lcirStatus :: Lens' ListContainerInstancesResponse Int
lcirStatus = lens _lcirStatus (\ s a -> s{_lcirStatus = a});
