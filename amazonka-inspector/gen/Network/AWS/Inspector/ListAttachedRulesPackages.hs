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
-- Module      : Network.AWS.Inspector.ListAttachedRulesPackages
-- Copyright   : (c) 2013-2015 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
--
-- Lists the rules packages attached to the assessment specified by the
-- assessment ARN.
--
-- /See:/ <http://docs.aws.amazon.com/inspector/latest/APIReference/API_ListAttachedRulesPackages.html AWS API Reference> for ListAttachedRulesPackages.
module Network.AWS.Inspector.ListAttachedRulesPackages
    (
    -- * Creating a Request
      listAttachedRulesPackages
    , ListAttachedRulesPackages
    -- * Request Lenses
    , larpAssessmentARN
    , larpNextToken
    , larpMaxResults

    -- * Destructuring the Response
    , listAttachedRulesPackagesResponse
    , ListAttachedRulesPackagesResponse
    -- * Response Lenses
    , larprsNextToken
    , larprsRulesPackageARNList
    , larprsResponseStatus
    ) where

import           Network.AWS.Inspector.Types
import           Network.AWS.Inspector.Types.Product
import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response

-- | /See:/ 'listAttachedRulesPackages' smart constructor.
data ListAttachedRulesPackages = ListAttachedRulesPackages'
    { _larpAssessmentARN :: !(Maybe Text)
    , _larpNextToken     :: !(Maybe Text)
    , _larpMaxResults    :: !(Maybe Int)
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | Creates a value of 'ListAttachedRulesPackages' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'larpAssessmentARN'
--
-- * 'larpNextToken'
--
-- * 'larpMaxResults'
listAttachedRulesPackages
    :: ListAttachedRulesPackages
listAttachedRulesPackages =
    ListAttachedRulesPackages'
    { _larpAssessmentARN = Nothing
    , _larpNextToken = Nothing
    , _larpMaxResults = Nothing
    }

-- | The ARN specifying the assessment whose rules packages you want to list.
larpAssessmentARN :: Lens' ListAttachedRulesPackages (Maybe Text)
larpAssessmentARN = lens _larpAssessmentARN (\ s a -> s{_larpAssessmentARN = a});

-- | You can use this parameter when paginating results. Set the value of
-- this parameter to \'null\' on your first call to the
-- __ListAttachedRulesPackages__ action. Subsequent calls to the action
-- fill __nextToken__ in the request with the value of __NextToken__ from
-- previous response to continue listing data.
larpNextToken :: Lens' ListAttachedRulesPackages (Maybe Text)
larpNextToken = lens _larpNextToken (\ s a -> s{_larpNextToken = a});

-- | You can use this parameter to indicate the maximum number of items you
-- want in the response. The default value is 10. The maximum value is 500.
larpMaxResults :: Lens' ListAttachedRulesPackages (Maybe Int)
larpMaxResults = lens _larpMaxResults (\ s a -> s{_larpMaxResults = a});

instance AWSRequest ListAttachedRulesPackages where
        type Rs ListAttachedRulesPackages =
             ListAttachedRulesPackagesResponse
        request = postJSON inspector
        response
          = receiveJSON
              (\ s h x ->
                 ListAttachedRulesPackagesResponse' <$>
                   (x .?> "nextToken") <*>
                     (x .?> "rulesPackageArnList" .!@ mempty)
                     <*> (pure (fromEnum s)))

instance ToHeaders ListAttachedRulesPackages where
        toHeaders
          = const
              (mconcat
                 ["X-Amz-Target" =#
                    ("InspectorService.ListAttachedRulesPackages" ::
                       ByteString),
                  "Content-Type" =#
                    ("application/x-amz-json-1.1" :: ByteString)])

instance ToJSON ListAttachedRulesPackages where
        toJSON ListAttachedRulesPackages'{..}
          = object
              (catMaybes
                 [("assessmentArn" .=) <$> _larpAssessmentARN,
                  ("nextToken" .=) <$> _larpNextToken,
                  ("maxResults" .=) <$> _larpMaxResults])

instance ToPath ListAttachedRulesPackages where
        toPath = const "/"

instance ToQuery ListAttachedRulesPackages where
        toQuery = const mempty

-- | /See:/ 'listAttachedRulesPackagesResponse' smart constructor.
data ListAttachedRulesPackagesResponse = ListAttachedRulesPackagesResponse'
    { _larprsNextToken           :: !(Maybe Text)
    , _larprsRulesPackageARNList :: !(Maybe [Text])
    , _larprsResponseStatus      :: !Int
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | Creates a value of 'ListAttachedRulesPackagesResponse' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'larprsNextToken'
--
-- * 'larprsRulesPackageARNList'
--
-- * 'larprsResponseStatus'
listAttachedRulesPackagesResponse
    :: Int -- ^ 'larprsResponseStatus'
    -> ListAttachedRulesPackagesResponse
listAttachedRulesPackagesResponse pResponseStatus_ =
    ListAttachedRulesPackagesResponse'
    { _larprsNextToken = Nothing
    , _larprsRulesPackageARNList = Nothing
    , _larprsResponseStatus = pResponseStatus_
    }

-- | When a response is generated, if there is more data to be listed, this
-- parameter is present in the response and contains the value to use for
-- the __nextToken__ parameter in a subsequent pagination request. If there
-- is no more data to be listed, this parameter is set to \'null\'.
larprsNextToken :: Lens' ListAttachedRulesPackagesResponse (Maybe Text)
larprsNextToken = lens _larprsNextToken (\ s a -> s{_larprsNextToken = a});

-- | A list of ARNs specifying the rules packages returned by the action.
larprsRulesPackageARNList :: Lens' ListAttachedRulesPackagesResponse [Text]
larprsRulesPackageARNList = lens _larprsRulesPackageARNList (\ s a -> s{_larprsRulesPackageARNList = a}) . _Default . _Coerce;

-- | The response status code.
larprsResponseStatus :: Lens' ListAttachedRulesPackagesResponse Int
larprsResponseStatus = lens _larprsResponseStatus (\ s a -> s{_larprsResponseStatus = a});
