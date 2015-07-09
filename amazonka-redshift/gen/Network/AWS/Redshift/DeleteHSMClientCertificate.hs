{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE RecordWildCards    #-}
{-# LANGUAGE TypeFamilies       #-}

-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- |
-- Module      : Network.AWS.Redshift.DeleteHSMClientCertificate
-- Copyright   : (c) 2013-2015 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)
--
-- Deletes the specified HSM client certificate.
--
-- <http://docs.aws.amazon.com/redshift/latest/APIReference/API_DeleteHSMClientCertificate.html>
module Network.AWS.Redshift.DeleteHSMClientCertificate
    (
    -- * Request
      DeleteHSMClientCertificate
    -- ** Request constructor
    , deleteHSMClientCertificate
    -- ** Request lenses
    , delHSMClientCertificateIdentifier

    -- * Response
    , DeleteHSMClientCertificateResponse
    -- ** Response constructor
    , deleteHSMClientCertificateResponse
    ) where

import           Network.AWS.Prelude
import           Network.AWS.Redshift.Types
import           Network.AWS.Request
import           Network.AWS.Response

-- |
--
-- /See:/ 'deleteHSMClientCertificate' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'delHSMClientCertificateIdentifier'
newtype DeleteHSMClientCertificate = DeleteHSMClientCertificate'
    { _delHSMClientCertificateIdentifier :: Text
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'DeleteHSMClientCertificate' smart constructor.
deleteHSMClientCertificate :: Text -> DeleteHSMClientCertificate
deleteHSMClientCertificate pHSMClientCertificateIdentifier =
    DeleteHSMClientCertificate'
    { _delHSMClientCertificateIdentifier = pHSMClientCertificateIdentifier
    }

-- | The identifier of the HSM client certificate to be deleted.
delHSMClientCertificateIdentifier :: Lens' DeleteHSMClientCertificate Text
delHSMClientCertificateIdentifier = lens _delHSMClientCertificateIdentifier (\ s a -> s{_delHSMClientCertificateIdentifier = a});

instance AWSRequest DeleteHSMClientCertificate where
        type Sv DeleteHSMClientCertificate = Redshift
        type Rs DeleteHSMClientCertificate =
             DeleteHSMClientCertificateResponse
        request = post
        response
          = receiveNull DeleteHSMClientCertificateResponse'

instance ToHeaders DeleteHSMClientCertificate where
        toHeaders = const mempty

instance ToPath DeleteHSMClientCertificate where
        toPath = const "/"

instance ToQuery DeleteHSMClientCertificate where
        toQuery DeleteHSMClientCertificate'{..}
          = mconcat
              ["Action" =:
                 ("DeleteHSMClientCertificate" :: ByteString),
               "Version" =: ("2012-12-01" :: ByteString),
               "HsmClientCertificateIdentifier" =:
                 _delHSMClientCertificateIdentifier]

-- | /See:/ 'deleteHSMClientCertificateResponse' smart constructor.
data DeleteHSMClientCertificateResponse =
    DeleteHSMClientCertificateResponse'
    deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'DeleteHSMClientCertificateResponse' smart constructor.
deleteHSMClientCertificateResponse :: DeleteHSMClientCertificateResponse
deleteHSMClientCertificateResponse = DeleteHSMClientCertificateResponse'
