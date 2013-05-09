{-# LANGUAGE OverloadedStrings #-}

import Network.API.TLDR
import Network.API.TLDR.Types

import qualified Data.ByteString.Lazy.Char8 as B
import Data.Aeson
import Control.Monad (when)
import System.Exit (exitFailure)
import Test.HUnit
    (Test(..), Counts(..),
         runTestTT, assertFailure,
         assertEqual, assertBool)

categoryJSONTest = TestCase $ do
    let decoded = decode "[{\"name\":\"World News\",\"slug\":\"world-news\"}, {\"name\":\"Tech News\",\"slug\":\"tech-news\"}]" :: Maybe [Category]
    case decoded of
        Nothing -> assertFailure "should be a list of Category types"
        Just categories -> do
                            assertEqual "two categories" 2 (length categories)
                            assertEqual "first name is World News" "World News" (categoryName $ head categories)
                            assertEqual "second name is Tech News" "Tech News" (categoryName $ categories !! 1)
                            assertEqual "first slug is world-news" "world-news" (categorySlug $ head categories)
                           -- etc.

unitTests = TestList
    [ TestLabel "Categories" categoryJSONTest ]

main = do counts <- runTestTT unitTests
          let bad = errors counts + failures counts
          when (bad > 0) exitFailure
