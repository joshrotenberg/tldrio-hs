{-# LANGUAGE OverloadedStrings #-}

module Network.API.TLDR.Types.User (
    User(..)
) where

import Control.Applicative
import Control.Monad (liftM)
import Data.Aeson
import Data.Aeson.Types (typeMismatch)
import Data.Time.LocalTime (ZonedTime(..))
import Network.API.TLDR.Types.Time (Time(..), CreatedAt(..), LastActive(..))

data Gravatar = Gravatar
    { gravatarUrl :: String
    } deriving (Eq, Show)

instance FromJSON Gravatar where
    parseJSON  (Object v) =
        Gravatar <$> v .: "url"
    parseJSON _ = empty

data User = User
    { userUsername :: String
    , userLastActive :: ZonedTime
    , userCreatedAt :: ZonedTime
    , userTwitterHandle :: String
    , userBio :: String
  --  , userGravatar :: Gravatar
    } deriving (Show)

instance FromJSON User where
    parseJSON (Object v) =
        User <$> v .: "username"
                 <*> liftM time (v .: "lastActive")
                 <*> liftM time (v .: "createdAt")
                 <*> v .:? "twitterHandle" .!= ""
                 <*> v .:? "bio" .!= ""
                       --                 <*> v .: "gravatar"
    parseJSON _ = empty
