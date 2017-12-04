{-# LANGUAGE TupleSections #-}

module Day4 where

import           Data.List (sort)
import qualified Data.Map  as Map

solution1 :: String -> Int
solution1 s = length $ filter (all (== 1)) ms
  where
    xs = map words $ lines s
    ms = map (Map.fromListWith (+) . map (, 1 :: Integer)) xs

solution2 :: String -> Int
solution2 s = length $ filter (all (== 1)) ms
  where
    xs = map (map sort . words) $ lines s
    ms = map (Map.fromListWith (+) . map (, 1 :: Integer)) xs
