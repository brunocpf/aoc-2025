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
          parent = connectPairs (newParent (length points)) (take 1000 (sortedPairs points))
      print (largestThreeProduct parent)

inputPath :: [String] -> Maybe FilePath
inputPath ("--input" : p : _) = Just p
inputPath ("-i" : p : _) = Just p
inputPath (p : _) = Just p
inputPath [] = Nothing
