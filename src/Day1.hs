module Day1 where

solution1 :: String -> Integer
solution1 s = sum [x | (x, y) <- zip digits (tail digits ++ [head digits]), x == y]
  where
    digits = map (read . (: [])) s

solution2 :: String -> Integer
solution2 s = sum [x | (x, y) <- zip digits (drop halfn digits ++ take halfn digits), x == y]
  where
    halfn = length s `quot` 2
    digits = map (read . (: [])) s
