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
    assertEqual "stuff" 1 1

categories = decode "[{\"name\":\"Foo Thing\",\"slug\":\"foo-thing\"}]" :: Maybe [Category]


unitTests = TestList
    [ TestLabel "Categories" categoryJSONTest ]

main = do counts <- runTestTT unitTests
          putStrLn categories
          let bad = errors counts + failures counts
          when (bad > 0) exitFailure
