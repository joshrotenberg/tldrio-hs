{-# LANGUAGE OverloadedStrings #-}

module Network.API.TLDR.Types.Category (
    Category(..)
) where

import Control.Applicative
import Data.Aeson
import Data.Aeson.Types (typeMismatch)

data Category = Category
    { categoryName :: String
    , categorySlug :: String
} deriving (Eq, Show)

instance FromJSON Category where
    parseJSON (Object v) =
        Category <$> v .: "name"
                 <*> v .: "slug"
    parseJSON _ = empty
