{-# LANGUAGE OverloadedStrings #-}

module Network.API.TLDR.Types.Time (
                                    Time(..),
                                    LastActive(..),
                                    CreatedAt(..)
) where

import Data.Aeson
import Data.Aeson.Types (typeMismatch)
import Data.Text (unpack)
import Data.Time (parseTime, Day(..))
import Data.Time.RFC3339 (readRFC3339)
import Data.Time.LocalTime (ZonedTime(..))
import System.Locale (defaultTimeLocale)

newtype Time = Time
        {time :: ZonedTime} deriving (Show)

instance FromJSON Time where
    parseJSON (String t) =
        case readRFC3339 (unpack t) of
          Just d -> return $ Time d
          _      -> fail "could not parse time"
    parseJSON v = typeMismatch "Time" v


type LastActive = Time
type CreatedAt = Time
