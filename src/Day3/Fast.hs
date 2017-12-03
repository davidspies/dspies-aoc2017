module Day3.Fast where

import           Data.List  (find)
import           Data.Maybe (fromJust)

solution1 :: String -> Integer
solution1 s = case read s of
  1 -> 0
  n -> stepsIn + stepsAlong
    where
      csqrtn = ceilsqrt n
      stepsIn = csqrtn `quot` 2
      sideLength = 2 * stepsIn + 1
      stepsUntilLowerRightCorner = sideLength ^ (2 :: Int) - n
      distToNextCorner = stepsUntilLowerRightCorner `rem` (sideLength - 1)
      stepsAlong = abs (stepsIn - distToNextCorner)

floorsqrt :: Integer -> Integer
floorsqrt n = fst $ fromJust $ find (uncurry (<=)) $ zip guesses (tail guesses)
  where
    takeStep guess = (guess + n `quot` guess) `quot` 2
    guess0 = ceiling $ sqrt (fromInteger n :: Double)
    guess1 = takeStep guess0
    guesses = iterate takeStep guess1

ceilsqrt :: Integer -> Integer
ceilsqrt n = floorsqrt (n - 1) + 1
