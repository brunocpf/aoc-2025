module Main (main) where

import Playground
import System.Exit (exitFailure)

example :: [Point]
example =
  parsePoints $
    unlines
      [ "162,817,812"
      , "57,618,57"
      , "906,360,560"
      , "592,479,940"
      , "352,342,300"
      , "466,668,158"
      , "542,29,236"
      , "431,825,988"
      , "739,650,466"
      , "52,470,668"
      , "216,146,977"
      , "819,987,18"
      , "117,168,530"
      , "805,96,715"
      , "346,949,466"
      , "970,615,88"
      , "941,993,340"
      , "862,61,35"
      , "984,92,344"
      , "425,690,689"
      ]

check :: String -> Bool -> IO Bool
check name ok = do
  putStrLn ((if ok then "ok " else "FAIL ") ++ name)
  pure ok

main :: IO ()
main = do
  let pairs = sortedPairs example
      parent = newParent (length example)
      Pair lastA lastB _ = lastMergingPair parent pairs
      Point x1 _ _ = example !! lastA
      Point x2 _ _ = example !! lastB
  results <-
    sequence
      [ check "part1" (largestThreeProduct (connectPairs parent (take 10 pairs)) == 40)
      , check "part2" (x1 * x2 == 25272)
      ]
  if and results then pure () else exitFailure
