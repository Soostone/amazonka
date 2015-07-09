{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE RecordWildCards    #-}
{-# LANGUAGE TypeFamilies       #-}

-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- |
-- Module      : Network.AWS.ECS.SubmitTaskStateChange
-- Copyright   : (c) 2013-2015 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)
--
-- This action is only used by the Amazon EC2 Container Service agent, and
-- it is not intended for use outside of the agent.
--
-- Sent to acknowledge that a task changed states.
--
-- <http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_SubmitTaskStateChange.html>
module Network.AWS.ECS.SubmitTaskStateChange
    (
    -- * Request
      SubmitTaskStateChange
    -- ** Request constructor
    , submitTaskStateChange
    -- ** Request lenses
    , stscStatus
    , stscCluster
    , stscReason
    , stscTask

    -- * Response
    , SubmitTaskStateChangeResponse
    -- ** Response constructor
    , submitTaskStateChangeResponse
    -- ** Response lenses
    , stscrAcknowledgment
    , stscrStatus
    ) where

import           Network.AWS.ECS.Types
import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response

-- | /See:/ 'submitTaskStateChange' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'stscStatus'
--
-- * 'stscCluster'
--
-- * 'stscReason'
--
-- * 'stscTask'
data SubmitTaskStateChange = SubmitTaskStateChange'
    { _stscStatus  :: !(Maybe Text)
    , _stscCluster :: !(Maybe Text)
    , _stscReason  :: !(Maybe Text)
    , _stscTask    :: !(Maybe Text)
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'SubmitTaskStateChange' smart constructor.
submitTaskStateChange :: SubmitTaskStateChange
submitTaskStateChange =
    SubmitTaskStateChange'
    { _stscStatus = Nothing
    , _stscCluster = Nothing
    , _stscReason = Nothing
    , _stscTask = Nothing
    }

-- | The status of the state change request.
stscStatus :: Lens' SubmitTaskStateChange (Maybe Text)
stscStatus = lens _stscStatus (\ s a -> s{_stscStatus = a});

-- | The short name or full Amazon Resource Name (ARN) of the cluster that
-- hosts the task.
stscCluster :: Lens' SubmitTaskStateChange (Maybe Text)
stscCluster = lens _stscCluster (\ s a -> s{_stscCluster = a});

-- | The reason for the state change request.
stscReason :: Lens' SubmitTaskStateChange (Maybe Text)
stscReason = lens _stscReason (\ s a -> s{_stscReason = a});

-- | The task UUID or full Amazon Resource Name (ARN) of the task in the
-- state change request.
stscTask :: Lens' SubmitTaskStateChange (Maybe Text)
stscTask = lens _stscTask (\ s a -> s{_stscTask = a});

instance AWSRequest SubmitTaskStateChange where
        type Sv SubmitTaskStateChange = ECS
        type Rs SubmitTaskStateChange =
             SubmitTaskStateChangeResponse
        request = postJSON
        response
          = receiveJSON
              (\ s h x ->
                 SubmitTaskStateChangeResponse' <$>
                   (x .?> "acknowledgment") <*> (pure (fromEnum s)))

instance ToHeaders SubmitTaskStateChange where
        toHeaders
          = const
              (mconcat
                 ["X-Amz-Target" =#
                    ("AmazonEC2ContainerServiceV20141113.SubmitTaskStateChange"
                       :: ByteString),
                  "Content-Type" =#
                    ("application/x-amz-json-1.1" :: ByteString)])

instance ToJSON SubmitTaskStateChange where
        toJSON SubmitTaskStateChange'{..}
          = object
              ["status" .= _stscStatus, "cluster" .= _stscCluster,
               "reason" .= _stscReason, "task" .= _stscTask]

instance ToPath SubmitTaskStateChange where
        toPath = const "/"

instance ToQuery SubmitTaskStateChange where
        toQuery = const mempty

-- | /See:/ 'submitTaskStateChangeResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'stscrAcknowledgment'
--
-- * 'stscrStatus'
data SubmitTaskStateChangeResponse = SubmitTaskStateChangeResponse'
    { _stscrAcknowledgment :: !(Maybe Text)
    , _stscrStatus         :: !Int
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'SubmitTaskStateChangeResponse' smart constructor.
submitTaskStateChangeResponse :: Int -> SubmitTaskStateChangeResponse
submitTaskStateChangeResponse pStatus =
    SubmitTaskStateChangeResponse'
    { _stscrAcknowledgment = Nothing
    , _stscrStatus = pStatus
    }

-- | Acknowledgement of the state change.
stscrAcknowledgment :: Lens' SubmitTaskStateChangeResponse (Maybe Text)
stscrAcknowledgment = lens _stscrAcknowledgment (\ s a -> s{_stscrAcknowledgment = a});

-- | FIXME: Undocumented member.
stscrStatus :: Lens' SubmitTaskStateChangeResponse Int
stscrStatus = lens _stscrStatus (\ s a -> s{_stscrStatus = a});
