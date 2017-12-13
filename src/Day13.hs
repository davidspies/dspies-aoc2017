module Day13 where

import           Control.Applicative           (some)
import           Data.Either                   (either)
import           Text.ParserCombinators.Parsec (digit, parse, sepBy, string)

solution1 :: String -> Integer
solution1 s = sum [k * v | (k, v) <- inp, caughtBy 0 (k, v)]
  where
    inp = parseInput s

caughtBy :: Integer -> (Integer, Integer) -> Bool
caughtBy delay (k, v) = v == 1 || (k + delay) `mod` (2 * (v - 1)) == 0

parseInput :: String -> [(Integer, Integer)]
parseInput s = [(read k, read v) | [k, v] <- lls]
  where
    lls = map (either (error "parse failed") id . parse (
        sepBy (some digit) (string ": ")
      ) "input") $ lines s

solution2 :: String -> Integer
solution2 s = head [delay | delay <- [0..], not $ any (caughtBy delay) inp]
  where
    inp = parseInput s
