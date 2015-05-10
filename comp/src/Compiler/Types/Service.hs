{-# LANGUAGE DataKinds              #-}
{-# LANGUAGE DeriveFoldable         #-}
{-# LANGUAGE DeriveFunctor          #-}
{-# LANGUAGE DeriveGeneric          #-}
{-# LANGUAGE DeriveTraversable      #-}
{-# LANGUAGE FlexibleContexts       #-}
{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE KindSignatures         #-}
{-# LANGUAGE LambdaCase             #-}
{-# LANGUAGE MultiParamTypeClasses  #-}
{-# LANGUAGE OverloadedStrings      #-}
{-# LANGUAGE RecordWildCards        #-}
{-# LANGUAGE StandaloneDeriving     #-}
{-# LANGUAGE TemplateHaskell        #-}
{-# LANGUAGE TupleSections          #-}
{-# LANGUAGE TypeOperators          #-}

-- Module      : Compiler.Types.Service
-- Copyright   : (c) 2013-2015 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla xtPublic License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

module Compiler.Types.Service where

import           Compiler.Text
import           Compiler.TH
import           Compiler.Types.Ann
import           Compiler.Types.Help
import           Compiler.Types.Id
import           Compiler.Types.Map
import           Compiler.Types.Orphans ()
import           Compiler.Types.URI
import           Control.Comonad.Cofree
import           Control.Lens           hiding ((.=))
import           Data.Aeson             (ToJSON (..))
import qualified Data.HashMap.Strict    as Map
import qualified Data.HashSet           as Set
import           Data.Jason             hiding (Bool, ToJSON (..), object, (.=))
import           Data.Text              (Text)
import qualified Data.Text              as Text
import           GHC.Generics           (Generic)
import           Numeric.Natural

type Set = Set.HashSet

data Signature
    = V2
    | V3
    | V3HTTPS
    | V4
    | S3
      deriving (Eq, Show, Generic)

instance FromJSON Signature where
    parseJSON = gParseJSON' lower

instance ToJSON Signature where
    toJSON = gToJSON' lower

data Protocol
    = JSON
    | RestJSON
    | XML
    | RestXML
    | Query
    | EC2
      deriving (Eq, Show, Generic)

instance FromJSON Protocol where
    parseJSON = gParseJSON' spinal

instance ToJSON Protocol where
    toJSON = gToJSON' spinal

data Timestamp
    = RFC822
    | ISO8601
    | POSIX
      deriving (Eq, Show, Generic)

instance FromJSON Timestamp where
    parseJSON = withText "timestamp" $ \case
        "rfc822"        -> pure RFC822
        "iso8601"       -> pure ISO8601
        "unixTimestamp" -> pure POSIX
        e               -> fail ("Unknown Timestamp: " ++ Text.unpack e)

instance ToJSON Timestamp where
    toJSON = gToJSON' lower

data Checksum
    = MD5
    | SHA256
      deriving (Eq, Show, Generic)

instance FromJSON Checksum where
    parseJSON = gParseJSON' lower

instance ToJSON Checksum where
    toJSON = gToJSON' lower

data Location
    = Headers
    | Header
    | URI
    | Querystring
    | StatusCode
    | Body -- FIXME: !Bool streaming
      deriving (Eq, Show, Generic)

instance FromJSON Location where
    parseJSON = gParseJSON' camel

instance ToJSON Location where
    toJSON = gToJSON' camel

data Method
    = GET
    | POST
    | HEAD
    | PUT
    | DELETE
      deriving (Eq, Show, Generic)

instance FromJSON Method where
    parseJSON = gParseJSON' upper

data XML = XML'
    { _xmlPrefix :: Text
    , _xmlUri    :: Text
    } deriving (Eq, Show, Generic)

makeLenses ''XML

instance FromJSON XML where
    parseJSON = gParseJSON' (camel & lenses .~ True)

data RefF a = RefF
    { _refAnn           :: a
    , _refShape         :: Id
    , _refDocumentation :: Maybe Help
    , _refLocation      :: Maybe Location
    , _refLocationName  :: Maybe Text
    , _refResultWrapper :: Maybe Text
    , _refQueryName     :: Maybe Text
    , _refStreaming     :: !Bool
--    , _refWrapper     :: !Bool
    , _refXMLAttribute  :: !Bool
    , _refXMLNamespace  :: Maybe XML
    } deriving (Show, Functor, Foldable, Traversable, Generic)

makeLenses ''RefF

-- refDocumentation :: Getter Ref Help
-- refDocumentation = to $
--     fromMaybe "FIXME: Undocumented reference." . _refDocumentation'

instance FromJSON (RefF ()) where
    parseJSON = withObject "ref" $ \o -> RefF ()
        <$> o .:  "shape"
        <*> o .:? "documentation"
        <*> o .:? "location"
        <*> o .:? "locationName"
        <*> o .:? "resultWrapper"
        <*> o .:? "queryName"
        <*> o .:? "streaming"    .!= False
        <*> o .:? "xmlAttribute" .!= False
        <*> o .:? "xmlnamespace"

data Info = Info
    { _infoDocumentation :: Maybe Help
    , _infoMin           :: Maybe Natural
    , _infoMax           :: Maybe Natural
    , _infoFlattened     :: !Bool
    , _infoSensitive     :: !Bool
    , _infoStreaming     :: !Bool
    , _infoException     :: !Bool
    } deriving (Show, Generic)

makeClassy ''Info

instance FromJSON Info where
    parseJSON = withObject "info" $ \o -> Info
        <$> o .:? "documentation"
        <*> o .:? "min"
        <*> o .:? "max"
        <*> o .:? "flattened" .!= False
        <*> o .:? "sensitive" .!= False
        <*> o .:? "streaming" .!= False
        <*> o .:? "exception" .!= False

nonEmpty :: HasInfo a => a -> Bool
nonEmpty = (> Just 0) . view infoMin

-- class HasRefs a b where
--     references :: Traversal' a (RefF b)

-- FIXME: Map shouldn't be used for struct fields to ensure ordering is the same as JSON,
-- due to the use of Jason.
--
-- Also a (simpler) Jason alternative would be nice.

-- FIXME: Parameterize Ref over a, which can be swapped out for the actual shape.
-- (Id -> Ref -> Shape) Forms a Field

-- _members [(Id, Ref)]

data StructF a = StructF
--    { _members  :: [(Id, a)]
    { _members  :: Map Id (RefF a)
    , _required :: Set Id
    , _payload  :: Maybe Id
    , _wrapper  :: !Bool
    } deriving (Show, Functor, Foldable, Traversable)

makeLenses ''StructF

-- instance HasRefs (Struct Ptr) Id where
--     references = members . each

instance FromJSON (StructF ()) where
    parseJSON = withObject "struct" $ \o -> StructF
        <$> o .:  "members"
        <*> o .:? "required" .!= mempty
        <*> o .:? "payload"
        <*> pure False

data ShapeF a
    = List   Info (RefF a)
    | Map    Info (RefF a) (RefF a)
    | Struct Info (StructF a)
    | Enum   Info (Map Text Text)
    | Lit    Info Lit
      deriving (Show, Functor, Foldable, Traversable)

makePrisms ''ShapeF

type Shape = Cofree ShapeF

references :: Traversal' (ShapeF a) (RefF a)
references f = \case
    List   i e   -> List   i <$> f e
    Map    i k v -> Map    i <$> f k <*> f v
    Struct i ms  -> Struct i <$> traverseOf (members . each) f ms
    s            -> pure s

instance HasInfo (ShapeF a) where
    info = lens f (flip g)
      where
        f = \case
            List   i _   -> i
            Map    i _ _ -> i
            Struct i _   -> i
            Enum   i _   -> i
            Lit    i _   -> i

        g i = \case
            List   _ e   -> List   i e
            Map    _ k v -> Map    i k v
            Struct _ ms  -> Struct i ms
            Enum   _ m   -> Enum   i m
            Lit    _ l   -> Lit    i l

instance FromJSON (ShapeF ()) where
    parseJSON = withObject "shape" $ \o -> do
        i <- parseJSON (Object o)
        t <- o .:  "type"
        m <- o .:? "enum"
        case t of
            "list"      -> List   i <$> o .: "member"
            "map"       -> Map    i <$> o .: "key" <*> o .: "value"
            "structure" -> Struct i <$> parseJSON (Object o)
            "integer"   -> pure (Lit i Int)
            "long"      -> pure (Lit i Long)
            "double"    -> pure (Lit i Double)
            "float"     -> pure (Lit i Double)
            "blob"      -> pure (Lit i Blob)
            "boolean"   -> pure (Lit i Bool)
            "timestamp" -> pure (Lit i Time)
            "string"    -> pure $
                maybe (Lit i Text)
                      (Enum i . Map.fromList . map renameBranch)
                      m
            _           -> fail $ "Unknown Shape type: " ++ Text.unpack t

data HTTP f = HTTP
    { _method       :: !Method
    , _requestURI   :: URI
    , _responseCode :: f Int
    } deriving (Generic)

makeClassy ''HTTP

instance FromJSON (HTTP Maybe) where
    parseJSON = gParseJSON' camel

data Operation f a = Operation
    { _opName          :: Id
    , _opDocumentation :: f Text
    , _opHTTP          :: HTTP f
    , _opInput         :: f a
    , _opOutput        :: f a
    }

makeLenses ''Operation

requestName, responseName :: Getter (Operation f a) Id
requestName  = to _opName
responseName = to ((`appendId` "Response") . _opName)

instance FromJSON (Operation Maybe (RefF ())) where
    parseJSON = withObject "operation" $ \o -> Operation
        <$> o .:  "name"
        <*> o .:? "documentation"
        <*> o .:  "http"
        <*> o .:? "input"
        <*> o .:? "output"

instance HasHTTP (Operation f a) f where
    hTTP = opHTTP

data Metadata f = Metadata
    { _protocol         :: !Protocol
    , _serviceAbbrev    :: Text
    , _serviceFullName  :: Text
    , _apiVersion       :: Text
    , _signatureVersion :: !Signature
    , _endpointPrefix   :: Text
    , _timestampFormat  :: f Timestamp
    , _checksumFormat   :: f Checksum
    , _jsonVersion      :: Text
    , _targetPrefix     :: Maybe Text
    } deriving (Generic)

makeClassy ''Metadata

instance FromJSON (Metadata Maybe) where
    parseJSON = withObject "meta" $ \o -> Metadata
        <$> o .:  "protocol"
        <*> o .:  "serviceAbbreviation"
        <*> o .:  "serviceFullName"
        <*> o .:  "apiVersion"
        <*> o .:  "signatureVersion"
        <*> o .:  "endpointPrefix"
        <*> o .:? "timestampFormat"
        <*> o .:? "checksumFormat"
        <*> o .:? "jsonVersion"     .!= "1.0"
        <*> o .:? "targetPrefix"

instance ToJSON (Metadata Identity) where
    toJSON = gToJSON' camel

data Service f a b = Service
    { _metadata'     :: Metadata f
    , _documentation :: Help
    , _operations    :: Map Id (Operation f a)
    , _shapes        :: Map Id b
    } deriving (Generic)

makeClassy ''Service

instance HasMetadata (Service f a b) f where
    metadata = metadata'

instance FromJSON (Service Maybe (RefF ()) (ShapeF ())) where
    parseJSON = gParseJSON' lower
