(ns day07.lab
  (:require [clojure.string :as str]))

(defn parse-manifold [contents]
  (let [rows (mapv vec (remove empty? (map str/trim (str/split-lines contents))))
        width (count (apply max-key count rows))]
    (loop [y 0]
      (if (>= y (count rows))
        {:start nil :grid rows}
        (let [x (.indexOf ^String (apply str (rows y)) (int \S))]
          (if (neg? x)
            (recur (inc y))
            {:start [x y] :grid (mapv #(vec (take width (concat % (repeat \.)))) rows)}))))))

(defn- cell-at [{:keys [grid]} x y]
  (when (and (<= 0 y) (< y (count grid)) (<= 0 x) (< x (count (grid y))))
    ((grid y) x)))

(defn count-splits [{:keys [start] :as manifold}]
  (loop [queued [start]
         visited #{}
         splits 0]
    (if-let [beam (peek queued)]
      (if (visited beam)
        (recur (pop queued) visited splits)
        (let [[x y] beam
              below-y (inc y)]
          (if (= \^ (cell-at manifold x below-y))
            (recur (into (pop queued) [[(dec x) below-y] [(inc x) below-y]])
                   (conj visited beam)
                   (inc splits))
            (recur (if (= \. (cell-at manifold x below-y))
                     (conj (pop queued) [x below-y])
                     (pop queued))
                   (conj visited beam)
                   splits))))
      splits)))

(defn count-timelines [{:keys [start] :as manifold}]
  (let [[start-x start-y] start
        last-y (dec (count (:grid manifold)))]
    (loop [y (inc start-y)
           counts {start-x 1}]
      (if (> y last-y)
        (reduce + (vals counts))
        (recur (inc y)
               (reduce (fn [acc [x n]]
                         (if (= \^ (cell-at manifold x y))
                           (-> acc
                               (update (dec x) (fnil + 0) n)
                               (update (inc x) (fnil + 0) n))
                           (update acc x (fnil + 0) n)))
                       {}
                       counts))))))
