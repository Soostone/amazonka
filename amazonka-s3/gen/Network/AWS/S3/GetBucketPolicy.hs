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
-- Module      : Network.AWS.S3.GetBucketPolicy
-- Copyright   : (c) 2013-2015 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
--
-- Returns the policy of a specified bucket.
--
-- /See:/ <http://docs.aws.amazon.com/AmazonS3/latest/API/GetBucketPolicy.html AWS API Reference> for GetBucketPolicy.
module Network.AWS.S3.GetBucketPolicy
    (
    -- * Creating a Request
      getBucketPolicy
    , GetBucketPolicy
    -- * Request Lenses
    , gbpBucket

    -- * Destructuring the Response
    , getBucketPolicyResponse
    , GetBucketPolicyResponse
    -- * Response Lenses
    , gbprsResponseStatus
    , gbprsPolicy
    ) where

import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response
import           Network.AWS.S3.Types
import           Network.AWS.S3.Types.Product

-- | /See:/ 'getBucketPolicy' smart constructor.
newtype GetBucketPolicy = GetBucketPolicy'
    { _gbpBucket :: BucketName
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | Creates a value of 'GetBucketPolicy' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'gbpBucket'
getBucketPolicy
    :: BucketName -- ^ 'gbpBucket'
    -> GetBucketPolicy
getBucketPolicy pBucket_ =
    GetBucketPolicy'
    { _gbpBucket = pBucket_
    }

-- | Undocumented member.
gbpBucket :: Lens' GetBucketPolicy BucketName
gbpBucket = lens _gbpBucket (\ s a -> s{_gbpBucket = a});

instance AWSRequest GetBucketPolicy where
        type Rs GetBucketPolicy = GetBucketPolicyResponse
        request = get s3
        response
          = receiveJSON
              (\ s h x ->
                 GetBucketPolicyResponse' <$>
                   (pure (fromEnum s)) <*> (pure x))

instance ToHeaders GetBucketPolicy where
        toHeaders = const mempty

instance ToPath GetBucketPolicy where
        toPath GetBucketPolicy'{..}
          = mconcat ["/", toBS _gbpBucket]

instance ToQuery GetBucketPolicy where
        toQuery = const (mconcat ["policy"])

-- | /See:/ 'getBucketPolicyResponse' smart constructor.
data GetBucketPolicyResponse = GetBucketPolicyResponse'
    { _gbprsResponseStatus :: !Int
    , _gbprsPolicy         :: !(HashMap Text Value)
    } deriving (Eq,Show,Data,Typeable,Generic)

-- | Creates a value of 'GetBucketPolicyResponse' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'gbprsResponseStatus'
--
-- * 'gbprsPolicy'
getBucketPolicyResponse
    :: Int -- ^ 'gbprsResponseStatus'
    -> HashMap Text Value -- ^ 'gbprsPolicy'
    -> GetBucketPolicyResponse
getBucketPolicyResponse pResponseStatus_ pPolicy_ =
    GetBucketPolicyResponse'
    { _gbprsResponseStatus = pResponseStatus_
    , _gbprsPolicy = pPolicy_
    }

-- | The response status code.
gbprsResponseStatus :: Lens' GetBucketPolicyResponse Int
gbprsResponseStatus = lens _gbprsResponseStatus (\ s a -> s{_gbprsResponseStatus = a});

-- | The bucket policy as a JSON document.
gbprsPolicy :: Lens' GetBucketPolicyResponse (HashMap Text Value)
gbprsPolicy = lens _gbprsPolicy (\ s a -> s{_gbprsPolicy = a});
