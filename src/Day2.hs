module Day2 where

import           Control.Monad (guard)

solution1 :: String -> Integer
solution1 s = sum $ map checksum vals
  where
    vals = map (map read . words) $ lines s
    checksum line = maximum line - minimum line

solution2 :: String -> Integer
solution2 s = sum $ map checksum vals
  where
    vals = map (map read . words) $ lines s
    checksum :: [Integer] -> Integer
    checksum line = head $ do
      (i, a) <- zip ([1..] :: [Integer]) line
      (j, b) <- zip [1..] line
      guard $ i /= j
      let (q, r) = a `quotRem` b
      [q | r == 0]
