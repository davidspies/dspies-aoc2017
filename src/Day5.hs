{-# LANGUAGE BangPatterns #-}

module Day5 where

import           Control.Monad.ST.Strict     (runST)
import           Data.Vector.Unboxed         (Vector)
import qualified Data.Vector.Unboxed         as Vector
import qualified Data.Vector.Unboxed.Mutable as MVector

solution1 :: String -> Int
solution1 s = runST $ do
    v <- Vector.thaw xs
    let lenxs = Vector.length xs
        loop i !count
          | i >= 0 && i < lenxs = do
              jump <- MVector.read v i
              MVector.write v i (jump + 1)
              loop (i + jump) (count + 1)
          | otherwise = return count
    loop 0 0
  where
    xs :: Vector Int
    xs = Vector.fromList $ map read $ lines s

solution2 :: String -> Int
solution2 s = runST $ do
    v <- Vector.thaw xs
    let lenxs = Vector.length xs
        loop i !count
          | i >= 0 && i < lenxs = do
              jump <- MVector.read v i
              let newjump = if jump >= 3 then jump - 1 else jump + 1
              MVector.write v i newjump
              loop (i + jump) (count + 1)
          | otherwise = return count
    loop 0 0
  where
    xs :: Vector Int
    xs = Vector.fromList $ map read $ lines s
