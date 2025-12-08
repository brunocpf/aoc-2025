(ns day07.main
  (:require [day07.lab :as lab])
  (:gen-class))

(defn- parse-args [args]
  (let [[flag-opt path-opt] args]
    (case flag-opt
      ("--input" "-i") path-opt
      (first args))))

(defn -main [& args]
  (let [[_ path-opt] args
        file-path (parse-args args)]
    (if-not file-path
      (do (println "Error: Please provide an input file using --input or -i.")
          (System/exit 1))
      (try
        (let [manifold (lab/parse-manifold (slurp file-path))]
          (println "Result:" (lab/count-timelines manifold)))
        (catch java.io.IOException e
          (println (str "Error reading file: " (.getMessage e)))
          (System/exit 1))))))
