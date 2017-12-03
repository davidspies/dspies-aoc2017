{-# LANGUAGE LambdaCase      #-}
{-# LANGUAGE RecordWildCards #-}

module Day3 where

import           Data.List       (find)
import           Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map
import           Data.Maybe      (fromJust, fromMaybe)
import           Prelude         hiding (repeat)

data Heading = N | E | S | W
  deriving (Show)

type Position = (Integer, Integer)
type PosDiff = (Integer, Integer)

data Turtle = Turtle
  { position :: Position
  , heading  :: Heading
  }
  deriving Show

incrDiff :: Heading -> PosDiff
incrDiff = \case
  N -> (0,1)
  E -> (1,0)
  S -> (0,-1)
  W -> (-1,0)

vecAdd :: Position -> PosDiff -> Position
vecAdd (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)

fd1 :: Turtle -> Turtle
fd1 Turtle{..} = Turtle{position = vecAdd position (incrDiff heading), ..}

leftOf :: Heading -> Heading
leftOf = \case
  N -> W
  W -> S
  S -> E
  E -> N

lt90 :: Turtle -> Turtle
lt90 Turtle{..} = Turtle{heading = leftOf heading, ..}

data Instr = Do (Turtle -> Turtle) | Save

scanInstrs :: [Instr] -> Turtle -> [Turtle]
scanInstrs instrs start = case instrs of
  []            -> []
  Save : rest   -> start : scanInstrs rest start
  Do act : rest -> scanInstrs rest (act start)

repeat :: Int -> [a] -> [a]
repeat n = concat . replicate n

spiralInstrs :: [Instr]
spiralInstrs =
  Save :
  (`concatMap` [2,4..]) (\n ->
    Do fd1 : Save :
    Do lt90 :
    repeat (n - 1) [Do fd1, Save] ++
    repeat 3 (
      Do lt90 :
      repeat n [Do fd1, Save]
    )
  )

spiralStart :: Turtle
spiralStart = Turtle{position=(0,0), heading=E}

walkPositions :: [Position]
walkPositions = map position $ scanInstrs spiralInstrs spiralStart

solution1 :: String -> Integer
solution1 s = let (x, y) = walkPositions !! (n - 1) in abs x + abs y
  where
    n = read s

adjacent :: Position -> [Position]
adjacent (x, y) = [(x', y') | x' <- [x-1..x+1], y' <- [y-1..y+1]]

(!+) :: (Ord k, Num v) => Map k v -> k -> v
(!+) m k = fromMaybe 0 $ Map.lookup k m

surroundSums :: [Integer]
surroundSums = go walkPositions (Map.singleton (0,0) 1)
  where
    go [] _       = []
    go (p : ps) m = surroundSum : go ps (Map.insert p surroundSum m)
      where
        surroundSum = sum $ map (m !+) $ adjacent p

solution2 :: String -> Integer
solution2 s = fromJust $ find (> n) surroundSums
  where
    n = read s
