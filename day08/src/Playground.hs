module Playground
  ( Point(..)
  , Pair(..)
  , parsePoints
  , sortedPairs
  , newParent
  , findRoot
  , componentCount
  , connectPairs
  , lastMergingPair
  , unionRoots
  , circuits
  , circuitSizes
  , largestThreeProduct
  ) where

import Data.Array (Array, bounds, listArray, (!), (//))
import Data.List (foldl', sortOn)
import Data.Map qualified as Map

data Point = Point !Int !Int !Int
  deriving (Show, Eq)

data Pair = Pair !Int !Int !Int
  deriving (Show, Eq)

distance :: Point -> Point -> Int
distance (Point x1 y1 z1) (Point x2 y2 z2) =
  let dx = x1 - x2
      dy = y1 - y2
      dz = z1 - z2
   in dx * dx + dy * dy + dz * dz

parsePoints :: String -> [Point]
parsePoints contents = map parseLine (filter (not . null) (lines contents))
 where
  parseLine line =
    case map (read :: String -> Int) (splitOn ',' line) of
      [x, y, z] -> Point x y z
      _ -> error ("invalid point: " ++ line)

splitOn :: Char -> String -> [String]
splitOn sep = go
 where
  go s = case break (== sep) s of
    (chunk, []) -> [chunk]
    (chunk, _ : rest) -> chunk : go rest

sortedPairs :: [Point] -> [Pair]
sortedPairs points =
  sortOn (\(Pair _ _ d) -> d)
    [ Pair i j (distance a b)
    | (i, a) <- zip [0 ..] points
    , (j, b) <- zip [i + 1 ..] (drop (i + 1) points)
    ]

newParent :: Int -> Array Int Int
newParent count = listArray (0, count - 1) [0 .. count - 1]

findRoot :: Array Int Int -> Int -> Int
findRoot parent i = go i
 where
  go j
    | parent ! j == j = j
    | otherwise = go (parent ! j)

componentCount :: Array Int Int -> Int
componentCount parent = length [i | i <- [lo .. hi], parent ! i == i]
 where
  (lo, hi) = bounds parent

connectPairs :: Array Int Int -> [Pair] -> Array Int Int
connectPairs = foldl' step
 where
  step acc (Pair a b _)
    | findRoot acc a == findRoot acc b = acc
    | otherwise = unionRoots acc a b

lastMergingPair :: Array Int Int -> [Pair] -> Pair
lastMergingPair parent pairs =
  let (_, merged) = foldl' step (parent, []) pairs
   in last merged
 where
  step (acc, merged) p@(Pair a b _)
    | findRoot acc a == findRoot acc b = (acc, merged)
    | otherwise = (unionRoots acc a b, merged ++ [p])

unionRoots :: Array Int Int -> Int -> Int -> Array Int Int
unionRoots parent a b = parent // [(rb, ra)]
 where
  ra = findRoot parent a
  rb = findRoot parent b

circuits :: Array Int Int -> [[Int]]
circuits parent = Map.elems (foldl insert Map.empty [lo .. hi])
 where
  (lo, hi) = bounds parent
  insert m i = Map.insertWith (++) (findRoot parent i) [i] m

circuitSizes :: Array Int Int -> [Int]
circuitSizes = map length . circuits

largestThreeProduct :: Array Int Int -> Int
largestThreeProduct parent = product (take 3 (reverse (sortOn id (circuitSizes parent))))
