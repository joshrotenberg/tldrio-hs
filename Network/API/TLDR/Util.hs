module Network.API.TLDR.Util (
    decodeStrict
) where

-- From https://github.com/bos/aeson/issues/99
-- This implements a decode on strict bytestrings which is what we get back from http-streams

import qualified Data.ByteString as B
import qualified Data.Aeson as A
import qualified Data.Attoparsec as AP

decodeStrict :: A.FromJSON a => B.ByteString -> Maybe a
decodeStrict bs = 
    case AP.parse A.json' bs of
        AP.Done _ v -> case A.fromJSON v of
            A.Success a -> Just a
            _           -> Nothing
        _           -> Nothing
