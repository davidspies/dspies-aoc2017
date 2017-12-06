module Main where

import           Day5

main :: IO ()
main = do
  s <- getContents
  print $ solution2 s
