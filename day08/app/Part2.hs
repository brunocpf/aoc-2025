module Main (main) where

import Playground
import System.Environment (getArgs)
import System.Exit (exitFailure)

main :: IO ()
main = do
  args <- getArgs
  case inputPath args of
    Nothing -> putStrLn "Error: Please provide an input file using --input or -i." >> exitFailure
    Just path -> do
      contents <- readFile path
      let points = parsePoints contents
          parent = newParent (length points)
          Pair lastA lastB _ = lastMergingPair parent (sortedPairs points)
          Point x1 _ _ = points !! lastA
          Point x2 _ _ = points !! lastB
      print (x1 * x2)

inputPath :: [String] -> Maybe FilePath
inputPath ("--input" : p : _) = Just p
inputPath ("-i" : p : _) = Just p
inputPath (p : _) = Just p
inputPath [] = Nothing
