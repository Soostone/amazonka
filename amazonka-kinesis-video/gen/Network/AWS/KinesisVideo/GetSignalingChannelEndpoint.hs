{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE StrictData #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# OPTIONS_GHC -fno-warn-unused-binds #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
{-# OPTIONS_GHC -fno-warn-unused-matches #-}

-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- |
-- Module      : Network.AWS.KinesisVideo.GetSignalingChannelEndpoint
-- Copyright   : (c) 2013-2021 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay+amazonka@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
--
-- Provides an endpoint for the specified signaling channel to send and
-- receive messages. This API uses the
-- @SingleMasterChannelEndpointConfiguration@ input parameter, which
-- consists of the @Protocols@ and @Role@ properties.
--
-- @Protocols@ is used to determine the communication mechanism. For
-- example, if you specify @WSS@ as the protocol, this API produces a
-- secure websocket endpoint. If you specify @HTTPS@ as the protocol, this
-- API generates an HTTPS endpoint.
--
-- @Role@ determines the messaging permissions. A @MASTER@ role results in
-- this API generating an endpoint that a client can use to communicate
-- with any of the viewers on the channel. A @VIEWER@ role results in this
-- API generating an endpoint that a client can use to communicate only
-- with a @MASTER@.
module Network.AWS.KinesisVideo.GetSignalingChannelEndpoint
  ( -- * Creating a Request
    GetSignalingChannelEndpoint (..),
    newGetSignalingChannelEndpoint,

    -- * Request Lenses
    getSignalingChannelEndpoint_singleMasterChannelEndpointConfiguration,
    getSignalingChannelEndpoint_channelARN,

    -- * Destructuring the Response
    GetSignalingChannelEndpointResponse (..),
    newGetSignalingChannelEndpointResponse,

    -- * Response Lenses
    getSignalingChannelEndpointResponse_resourceEndpointList,
    getSignalingChannelEndpointResponse_httpStatus,
  )
where

import Network.AWS.KinesisVideo.Types
import qualified Network.AWS.Lens as Lens
import qualified Network.AWS.Prelude as Prelude
import qualified Network.AWS.Request as Request
import qualified Network.AWS.Response as Response

-- | /See:/ 'newGetSignalingChannelEndpoint' smart constructor.
data GetSignalingChannelEndpoint = GetSignalingChannelEndpoint'
  { -- | A structure containing the endpoint configuration for the
    -- @SINGLE_MASTER@ channel type.
    singleMasterChannelEndpointConfiguration :: Prelude.Maybe SingleMasterChannelEndpointConfiguration,
    -- | The Amazon Resource Name (ARN) of the signalling channel for which you
    -- want to get an endpoint.
    channelARN :: Prelude.Text
  }
  deriving (Prelude.Eq, Prelude.Read, Prelude.Show, Prelude.Data, Prelude.Typeable, Prelude.Generic)

-- |
-- Create a value of 'GetSignalingChannelEndpoint' with all optional fields omitted.
--
-- Use <https://hackage.haskell.org/package/generic-lens generic-lens> or <https://hackage.haskell.org/package/optics optics> to modify other optional fields.
--
-- The following record fields are available, with the corresponding lenses provided
-- for backwards compatibility:
--
-- 'singleMasterChannelEndpointConfiguration', 'getSignalingChannelEndpoint_singleMasterChannelEndpointConfiguration' - A structure containing the endpoint configuration for the
-- @SINGLE_MASTER@ channel type.
--
-- 'channelARN', 'getSignalingChannelEndpoint_channelARN' - The Amazon Resource Name (ARN) of the signalling channel for which you
-- want to get an endpoint.
newGetSignalingChannelEndpoint ::
  -- | 'channelARN'
  Prelude.Text ->
  GetSignalingChannelEndpoint
newGetSignalingChannelEndpoint pChannelARN_ =
  GetSignalingChannelEndpoint'
    { singleMasterChannelEndpointConfiguration =
        Prelude.Nothing,
      channelARN = pChannelARN_
    }

-- | A structure containing the endpoint configuration for the
-- @SINGLE_MASTER@ channel type.
getSignalingChannelEndpoint_singleMasterChannelEndpointConfiguration :: Lens.Lens' GetSignalingChannelEndpoint (Prelude.Maybe SingleMasterChannelEndpointConfiguration)
getSignalingChannelEndpoint_singleMasterChannelEndpointConfiguration = Lens.lens (\GetSignalingChannelEndpoint' {singleMasterChannelEndpointConfiguration} -> singleMasterChannelEndpointConfiguration) (\s@GetSignalingChannelEndpoint' {} a -> s {singleMasterChannelEndpointConfiguration = a} :: GetSignalingChannelEndpoint)

-- | The Amazon Resource Name (ARN) of the signalling channel for which you
-- want to get an endpoint.
getSignalingChannelEndpoint_channelARN :: Lens.Lens' GetSignalingChannelEndpoint Prelude.Text
getSignalingChannelEndpoint_channelARN = Lens.lens (\GetSignalingChannelEndpoint' {channelARN} -> channelARN) (\s@GetSignalingChannelEndpoint' {} a -> s {channelARN = a} :: GetSignalingChannelEndpoint)

instance
  Prelude.AWSRequest
    GetSignalingChannelEndpoint
  where
  type
    Rs GetSignalingChannelEndpoint =
      GetSignalingChannelEndpointResponse
  request = Request.postJSON defaultService
  response =
    Response.receiveJSON
      ( \s h x ->
          GetSignalingChannelEndpointResponse'
            Prelude.<$> ( x Prelude..?> "ResourceEndpointList"
                            Prelude..!@ Prelude.mempty
                        )
            Prelude.<*> (Prelude.pure (Prelude.fromEnum s))
      )

instance Prelude.Hashable GetSignalingChannelEndpoint

instance Prelude.NFData GetSignalingChannelEndpoint

instance
  Prelude.ToHeaders
    GetSignalingChannelEndpoint
  where
  toHeaders = Prelude.const Prelude.mempty

instance Prelude.ToJSON GetSignalingChannelEndpoint where
  toJSON GetSignalingChannelEndpoint' {..} =
    Prelude.object
      ( Prelude.catMaybes
          [ ( "SingleMasterChannelEndpointConfiguration"
                Prelude..=
            )
              Prelude.<$> singleMasterChannelEndpointConfiguration,
            Prelude.Just ("ChannelARN" Prelude..= channelARN)
          ]
      )

instance Prelude.ToPath GetSignalingChannelEndpoint where
  toPath = Prelude.const "/getSignalingChannelEndpoint"

instance Prelude.ToQuery GetSignalingChannelEndpoint where
  toQuery = Prelude.const Prelude.mempty

-- | /See:/ 'newGetSignalingChannelEndpointResponse' smart constructor.
data GetSignalingChannelEndpointResponse = GetSignalingChannelEndpointResponse'
  { -- | A list of endpoints for the specified signaling channel.
    resourceEndpointList :: Prelude.Maybe [ResourceEndpointListItem],
    -- | The response's http status code.
    httpStatus :: Prelude.Int
  }
  deriving (Prelude.Eq, Prelude.Read, Prelude.Show, Prelude.Data, Prelude.Typeable, Prelude.Generic)

-- |
-- Create a value of 'GetSignalingChannelEndpointResponse' with all optional fields omitted.
--
-- Use <https://hackage.haskell.org/package/generic-lens generic-lens> or <https://hackage.haskell.org/package/optics optics> to modify other optional fields.
--
-- The following record fields are available, with the corresponding lenses provided
-- for backwards compatibility:
--
-- 'resourceEndpointList', 'getSignalingChannelEndpointResponse_resourceEndpointList' - A list of endpoints for the specified signaling channel.
--
-- 'httpStatus', 'getSignalingChannelEndpointResponse_httpStatus' - The response's http status code.
newGetSignalingChannelEndpointResponse ::
  -- | 'httpStatus'
  Prelude.Int ->
  GetSignalingChannelEndpointResponse
newGetSignalingChannelEndpointResponse pHttpStatus_ =
  GetSignalingChannelEndpointResponse'
    { resourceEndpointList =
        Prelude.Nothing,
      httpStatus = pHttpStatus_
    }

-- | A list of endpoints for the specified signaling channel.
getSignalingChannelEndpointResponse_resourceEndpointList :: Lens.Lens' GetSignalingChannelEndpointResponse (Prelude.Maybe [ResourceEndpointListItem])
getSignalingChannelEndpointResponse_resourceEndpointList = Lens.lens (\GetSignalingChannelEndpointResponse' {resourceEndpointList} -> resourceEndpointList) (\s@GetSignalingChannelEndpointResponse' {} a -> s {resourceEndpointList = a} :: GetSignalingChannelEndpointResponse) Prelude.. Lens.mapping Prelude._Coerce

-- | The response's http status code.
getSignalingChannelEndpointResponse_httpStatus :: Lens.Lens' GetSignalingChannelEndpointResponse Prelude.Int
getSignalingChannelEndpointResponse_httpStatus = Lens.lens (\GetSignalingChannelEndpointResponse' {httpStatus} -> httpStatus) (\s@GetSignalingChannelEndpointResponse' {} a -> s {httpStatus = a} :: GetSignalingChannelEndpointResponse)

instance
  Prelude.NFData
    GetSignalingChannelEndpointResponse