{-# LANGUAGE OverloadedStrings #-} 

module Network.API.TLDR.HTTP (
    requestAndParse
) where

import System.IO.Streams (InputStream, OutputStream, stdout)
import qualified System.IO.Streams as Streams
import qualified Data.ByteString as S
import Network.Http.Client
import Network.API.TLDR.Types
import Network.API.TLDR.Util (decodeStrict)
import OpenSSL (withOpenSSL)
import Data.Aeson

tldrAPIUrl :: Hostname
tldrAPIUrl = "api.tldr.io"

requestAndParse :: Request -> IO (Maybe User)
requestAndParse q = withOpenSSL $ do
    ctx <- baselineContextSSL
    c <- openConnectionSSL ctx tldrAPIUrl 443
    sendRequest c q emptyBody
    x <- receiveResponse c concatHandler
    closeConnection c
    return $ decode "{\"username\":\"doof\"}" 
