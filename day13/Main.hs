module Main where

import           Day13

main :: IO ()
main = do
  s <- getContents
  print $ solution2 s
