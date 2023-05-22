{-# LANGUAGE BlockArguments #-}

module Main where

import           MyLib (Reader (..))

newtype Config = Config{verbose :: Bool}

main :: IO ()
main = print $ runReader (Reader verbose) (Config {verbose = True})
