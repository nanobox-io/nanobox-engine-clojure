(ns user
  (:require [mount.core :as mount]
            simple_clojure.core))

(defn start []
  (mount/start-without #'simple_clojure.core/repl-server))

(defn stop []
  (mount/stop-except #'simple_clojure.core/repl-server))

(defn restart []
  (stop)
  (start))


