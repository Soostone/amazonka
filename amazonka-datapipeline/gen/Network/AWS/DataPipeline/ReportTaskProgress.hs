{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE RecordWildCards    #-}
{-# LANGUAGE TypeFamilies       #-}

-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- |
-- Module      : Network.AWS.DataPipeline.ReportTaskProgress
-- Copyright   : (c) 2013-2015 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)
--
-- Task runners call @ReportTaskProgress@ when assigned a task to
-- acknowledge that it has the task. If the web service does not receive
-- this acknowledgement within 2 minutes, it assigns the task in a
-- subsequent PollForTask call. After this initial acknowledgement, the
-- task runner only needs to report progress every 15 minutes to maintain
-- its ownership of the task. You can change this reporting time from 15
-- minutes by specifying a @reportProgressTimeout@ field in your pipeline.
--
-- If a task runner does not report its status after 5 minutes, AWS Data
-- Pipeline assumes that the task runner is unable to process the task and
-- reassigns the task in a subsequent response to PollForTask. Task runners
-- should call @ReportTaskProgress@ every 60 seconds.
--
-- <http://docs.aws.amazon.com/datapipeline/latest/APIReference/API_ReportTaskProgress.html>
module Network.AWS.DataPipeline.ReportTaskProgress
    (
    -- * Request
      ReportTaskProgress
    -- ** Request constructor
    , reportTaskProgress
    -- ** Request lenses
    , rtpFields
    , rtpTaskId

    -- * Response
    , ReportTaskProgressResponse
    -- ** Response constructor
    , reportTaskProgressResponse
    -- ** Response lenses
    , rtprStatus
    , rtprCanceled
    ) where

import           Network.AWS.DataPipeline.Types
import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response

-- | Contains the parameters for ReportTaskProgress.
--
-- /See:/ 'reportTaskProgress' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'rtpFields'
--
-- * 'rtpTaskId'
data ReportTaskProgress = ReportTaskProgress'
    { _rtpFields :: !(Maybe [Field])
    , _rtpTaskId :: !Text
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'ReportTaskProgress' smart constructor.
reportTaskProgress :: Text -> ReportTaskProgress
reportTaskProgress pTaskId =
    ReportTaskProgress'
    { _rtpFields = Nothing
    , _rtpTaskId = pTaskId
    }

-- | Key-value pairs that define the properties of the
-- ReportTaskProgressInput object.
rtpFields :: Lens' ReportTaskProgress [Field]
rtpFields = lens _rtpFields (\ s a -> s{_rtpFields = a}) . _Default;

-- | The ID of the task assigned to the task runner. This value is provided
-- in the response for PollForTask.
rtpTaskId :: Lens' ReportTaskProgress Text
rtpTaskId = lens _rtpTaskId (\ s a -> s{_rtpTaskId = a});

instance AWSRequest ReportTaskProgress where
        type Sv ReportTaskProgress = DataPipeline
        type Rs ReportTaskProgress =
             ReportTaskProgressResponse
        request = postJSON
        response
          = receiveJSON
              (\ s h x ->
                 ReportTaskProgressResponse' <$>
                   (pure (fromEnum s)) <*> (x .:> "canceled"))

instance ToHeaders ReportTaskProgress where
        toHeaders
          = const
              (mconcat
                 ["X-Amz-Target" =#
                    ("DataPipeline.ReportTaskProgress" :: ByteString),
                  "Content-Type" =#
                    ("application/x-amz-json-1.1" :: ByteString)])

instance ToJSON ReportTaskProgress where
        toJSON ReportTaskProgress'{..}
          = object
              ["fields" .= _rtpFields, "taskId" .= _rtpTaskId]

instance ToPath ReportTaskProgress where
        toPath = const "/"

instance ToQuery ReportTaskProgress where
        toQuery = const mempty

-- | Contains the output of ReportTaskProgress.
--
-- /See:/ 'reportTaskProgressResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'rtprStatus'
--
-- * 'rtprCanceled'
data ReportTaskProgressResponse = ReportTaskProgressResponse'
    { _rtprStatus   :: !Int
    , _rtprCanceled :: !Bool
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'ReportTaskProgressResponse' smart constructor.
reportTaskProgressResponse :: Int -> Bool -> ReportTaskProgressResponse
reportTaskProgressResponse pStatus pCanceled =
    ReportTaskProgressResponse'
    { _rtprStatus = pStatus
    , _rtprCanceled = pCanceled
    }

-- | FIXME: Undocumented member.
rtprStatus :: Lens' ReportTaskProgressResponse Int
rtprStatus = lens _rtprStatus (\ s a -> s{_rtprStatus = a});

-- | If true, the calling task runner should cancel processing of the task.
-- The task runner does not need to call SetTaskStatus for canceled tasks.
rtprCanceled :: Lens' ReportTaskProgressResponse Bool
rtprCanceled = lens _rtprCanceled (\ s a -> s{_rtprCanceled = a});
