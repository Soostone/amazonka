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
-- Module      : Network.AWS.APIGateway.DeleteRestAPI
-- Copyright   : (c) 2013-2015 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
--
-- Deletes the specified API.
--
-- /See:/ <http://docs.aws.amazon.com/apigateway/api-reference/resource/DeleteRestAPI.html AWS API Reference> for DeleteRestAPI.
module Network.AWS.APIGateway.DeleteRestAPI
    (
    -- * Creating a Request
      deleteRestAPI
    , DeleteRestAPI
    -- * Request Lenses
    , draRestAPIId

    -- * Destructuring the Response
    , deleteRestAPIResponse
    , DeleteRestAPIResponse
    ) where

import           Network.AWS.APIGateway.Types
import           Network.AWS.APIGateway.Types.Product
import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response

-- | Request to delete the specified API from your collection.
--
-- /See:/ 'deleteRestAPI' smart constructor.
newtype DeleteRestAPI = DeleteRestAPI'
    { _draRestAPIId :: Text
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | Creates a value of 'DeleteRestAPI' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'draRestAPIId'
deleteRestAPI
    :: Text -- ^ 'draRestAPIId'
    -> DeleteRestAPI
deleteRestAPI pRestAPIId_ =
    DeleteRestAPI'
    { _draRestAPIId = pRestAPIId_
    }

-- | The ID of the RestApi you want to delete.
draRestAPIId :: Lens' DeleteRestAPI Text
draRestAPIId = lens _draRestAPIId (\ s a -> s{_draRestAPIId = a});

instance AWSRequest DeleteRestAPI where
        type Rs DeleteRestAPI = DeleteRestAPIResponse
        request = delete aPIGateway
        response = receiveNull DeleteRestAPIResponse'

instance ToHeaders DeleteRestAPI where
        toHeaders = const mempty

instance ToPath DeleteRestAPI where
        toPath DeleteRestAPI'{..}
          = mconcat ["/restapis/", toBS _draRestAPIId]

instance ToQuery DeleteRestAPI where
        toQuery = const mempty

-- | /See:/ 'deleteRestAPIResponse' smart constructor.
data DeleteRestAPIResponse =
    DeleteRestAPIResponse'
    deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | Creates a value of 'DeleteRestAPIResponse' with the minimum fields required to make a request.
--
deleteRestAPIResponse
    :: DeleteRestAPIResponse
deleteRestAPIResponse = DeleteRestAPIResponse'
