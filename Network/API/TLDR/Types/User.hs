{-# LANGUAGE OverloadedStrings #-}

module Network.API.TLDR.Types.User (
    User(..)
) where

import Control.Applicative
import Data.Aeson
import Data.Aeson.Types (typeMismatch)

data Gravatar = Gravatar
    { gravatarUrl :: String
    } deriving (Eq, Show)

data User = User
    { userUsername :: String
    , userLastActive :: String
    , userCreatedAt :: String
    , userGravatar :: Gravatar
    } deriving (Eq, Show)

instance FromJSON User where
    parseJSON (Object v) =
        User <$> v .: "username"
                 <*> v .: " slug"
    parseJSON _ = empty
