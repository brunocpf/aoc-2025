(ns day07.lab-test
  (:require [clojure.test :refer [deftest is]]
            [day07.lab :as lab]))

(def example
  (str ".......S.......\n"
       "...............\n"
       ".......^.......\n"
       "...............\n"
       "......^.^......\n"
       "...............\n"
       ".....^.^.^.....\n"
       "...............\n"
       "....^.^...^....\n"
       "...............\n"
       "...^.^...^.^...\n"
       "...............\n"
       "..^...^.....^..\n"
       "...............\n"
       ".^.^.^.^.^...^.\n"
       "..............."))

(deftest count-splits-test
  (is (= 21 (lab/count-splits (lab/parse-manifold example)))))

(deftest count-timelines-test
  (is (= 40 (lab/count-timelines (lab/parse-manifold example)))))
