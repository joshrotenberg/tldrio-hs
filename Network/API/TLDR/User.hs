{-# LANGUAGE OverloadedStrings #-} 

module Network.API.TLDR.User (
    fetchUser
) where

import Network.API.TLDR.HTTP
import Data.Aeson
import Network.Http.Client
import qualified Data.ByteString.Char8 as S

fetchUser username = do
    q <- buildRequest $ do
        http GET path
        setAccept "application/json"

    requestAndParse q
    where path = S.pack $ "/users/" ++ username


