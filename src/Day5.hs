module Day5 where

import           Control.Monad.Loops         (whileM_)
import           Control.Monad.ST            (runST)
import           Data.STRef.Strict           (modifySTRef, newSTRef, readSTRef,
                                              writeSTRef)
import           Data.Vector.Unboxed         (Vector)
import qualified Data.Vector.Unboxed         as Vector
import qualified Data.Vector.Unboxed.Mutable as MVector

solution1 :: String -> Int
solution1 s = runST $ do
    v <- Vector.thaw xs
    iRef <- newSTRef 0
    countRef <- newSTRef (0 :: Int)
    let lenxs = Vector.length xs
    whileM_ ((\i -> i >= 0 && i < lenxs) <$> readSTRef iRef) $ do
      i <- readSTRef iRef
      jump <- MVector.read v i
      MVector.write v i (jump + 1)
      writeSTRef iRef (i + jump)
      modifySTRef countRef (+ 1)
    readSTRef countRef
  where
    xs :: Vector Int
    xs = Vector.fromList $ map read $ lines s

solution2 :: String -> Int
solution2 s = runST $ do
    v <- Vector.thaw xs
    iRef <- newSTRef 0
    countRef <- newSTRef (0 :: Int)
    let lenxs = Vector.length xs
    whileM_ ((\i -> i >= 0 && i < lenxs) <$> readSTRef iRef) $ do
      i <- readSTRef iRef
      jump <- MVector.read v i
      let newjump = if jump >= 3 then jump - 1 else jump + 1
      MVector.write v i newjump
      writeSTRef iRef (i + jump)
      modifySTRef countRef (+ 1)
    readSTRef countRef
  where
    xs :: Vector Int
    xs = Vector.fromList $ map read $ lines s
