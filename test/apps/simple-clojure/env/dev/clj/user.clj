(ns user
  (:require [mount.core :as mount]
            simple-clojure.core))

(defn start []
  (mount/start-without #'simple-clojure.core/repl-server))

(defn stop []
  (mount/stop-except #'simple-clojure.core/repl-server))

(defn restart []
  (stop)
  (start))


