{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE FlexibleInstances  #-}
{-# LANGUAGE LambdaCase         #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE TemplateHaskell    #-}

-- Module      : Gen.Types.Ann
-- Copyright   : (c) 2013-2015 Brendan Hay
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : provisional
-- Portability : non-portable (GHC extensions)

module Gen.Types.Ann where

import           Control.Comonad
import           Control.Comonad.Cofree
import           Control.Lens
import           Data.Aeson
import           Data.Function          (on)
import           Data.Hashable
import qualified Data.HashSet           as Set
import           Data.Monoid
import           Data.Text              (Text)
import qualified Data.Text              as Text
import           Gen.TH
import           Gen.Types.Id
import           GHC.Generics           (Generic)

type Set = Set.HashSet

data Direction
   = Output
   | Input
     deriving (Eq, Show, Generic)

instance Hashable Direction

data Mode
    = Bi
    | Uni !Direction
      deriving (Eq, Show)

instance Monoid Mode where
    mempty                  = Bi
    mappend (Uni i) (Uni o)
        | i == o            = Uni o
    mappend _       _       = Bi

data Relation = Relation
    { _relShared :: !Int -- FIXME: get around to using something more sensible.
    , _relMode   :: !Mode
    } deriving (Eq, Show)

makeClassy ''Relation

instance Monoid Relation where
    mempty      = Relation 0 mempty
    mappend a b = Relation (on add _relShared b a) (on (<>) _relMode b a)
      where
        add 0 0 = 2
        add 1 0 = 2
        add 0 1 = 2
        add x y = x + y

instance (Functor f, HasRelation a) => HasRelation (Cofree f a) where
    relation = lens extract (flip (:<) . unwrap) . relation

mkRelation :: Maybe Id -> Direction -> Relation
mkRelation p = Relation (maybe 0 (const 1) p) . Uni

isShared :: HasRelation a => a -> Bool
isShared = (> 1) . view relShared

isOrphan :: HasRelation a => a -> Bool
isOrphan = (== 0) . view relShared

data Derive
    = DEq
    | DOrd
    | DRead
    | DShow
    | DEnum
    | DNum
    | DIntegral
    | DReal
    | DRealFrac
    | DRealFloat
    | DMonoid
    | DSemigroup
    | DIsString
    | DData
    | DTypeable
    | DGeneric
      deriving (Eq, Ord, Show, Generic)

instance Hashable Derive

instance FromJSON Derive where
    parseJSON = gParseJSON' (spinal & ctor %~ (. Text.drop 1))

data Lit
    = Int
    | Long
    | Double
    | Text
    | Blob
    | Time
    | Bool
    | Json
      deriving (Show)

data TType
    = TType      Text [Derive]
    | TLit       Lit
    | TNatural
    | TStream
    | TMaybe     TType
    | TSensitive TType
    | TList      TType
    | TList1     TType
    | TMap       TType TType
      deriving (Show)

data Related = Related
    { _annId       :: Id
    , _annRelation :: Relation
    } deriving (Show)

makeClassy ''Related

instance (Functor f, HasRelated a) => HasRelated (Cofree f a) where
    related = lens extract (flip (:<) . unwrap) . related

instance HasId Related where
    identifier = view annId

instance HasRelation Related where
    relation = annRelation

data Prefixed = Prefixed
    { _annRelated :: Related
    , _annPrefix  :: Maybe Text
    } deriving (Show)

makeClassy ''Prefixed

instance (Functor f, HasPrefixed a) => HasPrefixed (Cofree f a) where
    prefixed = lens extract (flip (:<) . unwrap) . prefixed

instance HasRelation Prefixed where
    relation = related . relation

instance HasRelated Prefixed where
    related = annRelated

instance HasId Prefixed where
    identifier = view annId

data Solved = Solved
    { _annPrefixed :: Prefixed
    , _annType     :: TType
    } deriving (Show)

makeClassy ''Solved

instance (Functor f, HasSolved a) => HasSolved (Cofree f a) where
    solved = lens extract (flip (:<) . unwrap) . solved

instance HasRelation Solved where
    relation = prefixed . relation

instance HasRelated Solved where
    related = prefixed . related

instance HasPrefixed Solved where
    prefixed = annPrefixed

instance HasId Solved where
    identifier = view annId
