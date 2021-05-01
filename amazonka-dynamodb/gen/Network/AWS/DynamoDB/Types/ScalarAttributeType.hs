{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE PatternSynonyms #-}
{-# LANGUAGE StrictData #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}

-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- |
-- Module      : Network.AWS.DynamoDB.Types.ScalarAttributeType
-- Copyright   : (c) 2013-2021 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay+amazonka@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
module Network.AWS.DynamoDB.Types.ScalarAttributeType
  ( ScalarAttributeType
      ( ..,
        ScalarAttributeType_B,
        ScalarAttributeType_N,
        ScalarAttributeType_S
      ),
  )
where

import qualified Network.AWS.Prelude as Prelude

newtype ScalarAttributeType = ScalarAttributeType'
  { fromScalarAttributeType ::
      Prelude.Text
  }
  deriving
    ( Prelude.Show,
      Prelude.Read,
      Prelude.Eq,
      Prelude.Ord,
      Prelude.Data,
      Prelude.Typeable,
      Prelude.Generic,
      Prelude.Hashable,
      Prelude.NFData,
      Prelude.FromText,
      Prelude.ToText,
      Prelude.ToByteString,
      Prelude.ToLog,
      Prelude.ToHeader,
      Prelude.ToQuery,
      Prelude.FromJSON,
      Prelude.FromJSONKey,
      Prelude.ToJSON,
      Prelude.ToJSONKey,
      Prelude.FromXML,
      Prelude.ToXML
    )

pattern ScalarAttributeType_B :: ScalarAttributeType
pattern ScalarAttributeType_B = ScalarAttributeType' "B"

pattern ScalarAttributeType_N :: ScalarAttributeType
pattern ScalarAttributeType_N = ScalarAttributeType' "N"

pattern ScalarAttributeType_S :: ScalarAttributeType
pattern ScalarAttributeType_S = ScalarAttributeType' "S"

{-# COMPLETE
  ScalarAttributeType_B,
  ScalarAttributeType_N,
  ScalarAttributeType_S,
  ScalarAttributeType'
  #-}