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
-- Module      : Network.AWS.APIGateway.CreateStage
-- Copyright   : (c) 2013-2015 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
--
-- Creates a Stage resource.
--
-- /See:/ <http://docs.aws.amazon.com/apigateway/api-reference/resource/CreateStage.html AWS API Reference> for CreateStage.
module Network.AWS.APIGateway.CreateStage
    (
    -- * Creating a Request
      createStage
    , CreateStage
    -- * Request Lenses
    , csCacheClusterSize
    , csCacheClusterEnabled
    , csDescription
    , csRestAPIId
    , csStageName
    , csDeploymentId

    -- * Destructuring the Response
    , stage
    , Stage
    -- * Response Lenses
    , sDeploymentId
    , sClientCertificateId
    , sCreatedDate
    , sCacheClusterStatus
    , sMethodSettings
    , sLastUpdatedDate
    , sCacheClusterSize
    , sCacheClusterEnabled
    , sStageName
    , sDescription
    ) where

import           Network.AWS.APIGateway.Types
import           Network.AWS.APIGateway.Types.Product
import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response

-- | Requests Amazon API Gateway to create a Stage resource.
--
-- /See:/ 'createStage' smart constructor.
data CreateStage = CreateStage'
    { _csCacheClusterSize    :: !(Maybe CacheClusterSize)
    , _csCacheClusterEnabled :: !(Maybe Bool)
    , _csDescription         :: !(Maybe Text)
    , _csRestAPIId           :: !Text
    , _csStageName           :: !Text
    , _csDeploymentId        :: !Text
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | Creates a value of 'CreateStage' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'csCacheClusterSize'
--
-- * 'csCacheClusterEnabled'
--
-- * 'csDescription'
--
-- * 'csRestAPIId'
--
-- * 'csStageName'
--
-- * 'csDeploymentId'
createStage
    :: Text -- ^ 'csRestAPIId'
    -> Text -- ^ 'csStageName'
    -> Text -- ^ 'csDeploymentId'
    -> CreateStage
createStage pRestAPIId_ pStageName_ pDeploymentId_ =
    CreateStage'
    { _csCacheClusterSize = Nothing
    , _csCacheClusterEnabled = Nothing
    , _csDescription = Nothing
    , _csRestAPIId = pRestAPIId_
    , _csStageName = pStageName_
    , _csDeploymentId = pDeploymentId_
    }

-- | The stage\'s cache cluster size.
csCacheClusterSize :: Lens' CreateStage (Maybe CacheClusterSize)
csCacheClusterSize = lens _csCacheClusterSize (\ s a -> s{_csCacheClusterSize = a});

-- | Whether cache clustering is enabled for the stage.
csCacheClusterEnabled :: Lens' CreateStage (Maybe Bool)
csCacheClusterEnabled = lens _csCacheClusterEnabled (\ s a -> s{_csCacheClusterEnabled = a});

-- | The description of the Stage resource.
csDescription :: Lens' CreateStage (Maybe Text)
csDescription = lens _csDescription (\ s a -> s{_csDescription = a});

-- | The identifier of the RestApi resource for the Stage resource to create.
csRestAPIId :: Lens' CreateStage Text
csRestAPIId = lens _csRestAPIId (\ s a -> s{_csRestAPIId = a});

-- | The name for the Stage resource.
csStageName :: Lens' CreateStage Text
csStageName = lens _csStageName (\ s a -> s{_csStageName = a});

-- | The identifier of the Deployment resource for the Stage resource.
csDeploymentId :: Lens' CreateStage Text
csDeploymentId = lens _csDeploymentId (\ s a -> s{_csDeploymentId = a});

instance AWSRequest CreateStage where
        type Rs CreateStage = Stage
        request = postJSON aPIGateway
        response = receiveJSON (\ s h x -> eitherParseJSON x)

instance ToHeaders CreateStage where
        toHeaders = const mempty

instance ToJSON CreateStage where
        toJSON CreateStage'{..}
          = object
              (catMaybes
                 [("cacheClusterSize" .=) <$> _csCacheClusterSize,
                  ("cacheClusterEnabled" .=) <$>
                    _csCacheClusterEnabled,
                  ("description" .=) <$> _csDescription,
                  Just ("stageName" .= _csStageName),
                  Just ("deploymentId" .= _csDeploymentId)])

instance ToPath CreateStage where
        toPath CreateStage'{..}
          = mconcat
              ["/restapis/", toBS _csRestAPIId, "/stages"]

instance ToQuery CreateStage where
        toQuery = const mempty
