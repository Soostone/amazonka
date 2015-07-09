{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE RecordWildCards    #-}
{-# LANGUAGE TypeFamilies       #-}

-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- |
-- Module      : Network.AWS.SSM.GetDocument
-- Copyright   : (c) 2013-2015 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)
--
-- Gets the contents of the specified configuration document.
--
-- <http://docs.aws.amazon.com/ssm/latest/APIReference/API_GetDocument.html>
module Network.AWS.SSM.GetDocument
    (
    -- * Request
      GetDocument
    -- ** Request constructor
    , getDocument
    -- ** Request lenses
    , gdName

    -- * Response
    , GetDocumentResponse
    -- ** Response constructor
    , getDocumentResponse
    -- ** Response lenses
    , gdrContent
    , gdrName
    , gdrStatus
    ) where

import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response
import           Network.AWS.SSM.Types

-- | /See:/ 'getDocument' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'gdName'
newtype GetDocument = GetDocument'
    { _gdName :: Text
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'GetDocument' smart constructor.
getDocument :: Text -> GetDocument
getDocument pName =
    GetDocument'
    { _gdName = pName
    }

-- | The name of the configuration document.
gdName :: Lens' GetDocument Text
gdName = lens _gdName (\ s a -> s{_gdName = a});

instance AWSRequest GetDocument where
        type Sv GetDocument = SSM
        type Rs GetDocument = GetDocumentResponse
        request = postJSON
        response
          = receiveJSON
              (\ s h x ->
                 GetDocumentResponse' <$>
                   (x .?> "Content") <*> (x .?> "Name") <*>
                     (pure (fromEnum s)))

instance ToHeaders GetDocument where
        toHeaders
          = const
              (mconcat
                 ["X-Amz-Target" =#
                    ("AmazonSSM.GetDocument" :: ByteString),
                  "Content-Type" =#
                    ("application/x-amz-json-1.1" :: ByteString)])

instance ToJSON GetDocument where
        toJSON GetDocument'{..} = object ["Name" .= _gdName]

instance ToPath GetDocument where
        toPath = const "/"

instance ToQuery GetDocument where
        toQuery = const mempty

-- | /See:/ 'getDocumentResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'gdrContent'
--
-- * 'gdrName'
--
-- * 'gdrStatus'
data GetDocumentResponse = GetDocumentResponse'
    { _gdrContent :: !(Maybe Text)
    , _gdrName    :: !(Maybe Text)
    , _gdrStatus  :: !Int
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'GetDocumentResponse' smart constructor.
getDocumentResponse :: Int -> GetDocumentResponse
getDocumentResponse pStatus =
    GetDocumentResponse'
    { _gdrContent = Nothing
    , _gdrName = Nothing
    , _gdrStatus = pStatus
    }

-- | The contents of the configuration document.
gdrContent :: Lens' GetDocumentResponse (Maybe Text)
gdrContent = lens _gdrContent (\ s a -> s{_gdrContent = a});

-- | The name of the configuration document.
gdrName :: Lens' GetDocumentResponse (Maybe Text)
gdrName = lens _gdrName (\ s a -> s{_gdrName = a});

-- | FIXME: Undocumented member.
gdrStatus :: Lens' GetDocumentResponse Int
gdrStatus = lens _gdrStatus (\ s a -> s{_gdrStatus = a});
