{-# LANGUAGE OverloadedStrings #-}

module Network.API.TLDR.Types.TLDR (
                                    Domain(..),
                                    Creator(..),
                                    Language(..),
                                    Editor(..),
                                    TLDR(..)
) where

import Network.API.TLDR.Types.Category
import Control.Applicative
import Control.Monad (liftM)
import Data.Aeson
import Data.Aeson.Types (typeMismatch)

-- | Domain Type
data Domain = Domain
    { domainName :: String
    , domainSlug :: String
    } deriving (Eq, Show)

instance FromJSON Domain where
    parseJSON (Object v) = Domain <$>
        v .: "name" <*>
        v .: "slug"
    parseJSON _ = empty

-- | Language Type
data Language = Language
    { languageCode :: String
    , languageConfidence :: Double
    } deriving (Eq, Show)

instance FromJSON Language where
    parseJSON (Object v) = Language <$>
        v .: "language" <*>
        v .: "confidence"
    parseJSON _ = empty

-- | Creator Type
data Creator = Creator
    { creatorUsernameForDisplay :: String
    , creatorDeleted :: Bool
    , creatorUsername :: String
    , creatorId :: String
    , creatorIsAdmin :: Bool
    } deriving (Eq, Show)

instance FromJSON Creator where
    parseJSON (Object v) = Creator <$>
        v .: "usernameForDisplay" <*>
        v .: "deleted" <*>
        v .: "username" <*>
        v .: "id" <*>
        v .: "isAdmin"
    parseJSON _ = empty

type Editor = Creator

-- | TLDR Type
data TLDR = TLDR 
    { tldrTitle :: String
    , tldrModerated :: Bool
    , tldrPermalink :: String
    , tldCategories :: [Category]
    , tldrOriginalUrl :: String
    , tldrPossibleUrls :: [String]
    , tldrImageUrl :: String
    , tldrSummaryBullets :: [String]
    , tldrTimeSaved :: String
    , tldrSlug :: String
    , tldrWordCount :: Int
    , tldrReadCount :: Int
    , tldrArticleWordCount :: Int
    , tldrAnonymous :: Bool
    , tldrDomain :: Domain
    , tldrLanguage :: Language
    , tldrCreator :: Creator
    , tldrEditors :: [Editor]
    } deriving (Eq, Show)

instance FromJSON TLDR where
    parseJSON (Object v) = TLDR <$>
        v .: "title" <*>
        v .: "moderated" <*>
        v .: "permalink" <*>
        v .: "categories" <*>
        v .: "originalUrl" <*>
        v .: "possibleUrls" <*>
        v .: "imageUrl" <*>
        v .: "summaryBullets" <*>
        v .: "timeSaved"  <*>
        v .: "slug" <*>
        v .: "wordCount" <*>
        v .: "readCount" <*>
        v .: "articleWordCount" <*>
        v .: "anonymous" <*>
        v .: "domain" <*>
        v .: "language" <*>
        v .: "creator" <*>
        v .: "editors"
    parseJSON _ = empty
