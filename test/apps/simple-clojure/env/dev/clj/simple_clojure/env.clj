(ns simple-clojure.env
  (:require [selmer.parser :as parser]
            [clojure.tools.logging :as log]
            [simple-clojure.dev-middleware :refer [wrap-dev]]))

(def defaults
  {:init
   (fn []
     (parser/cache-off!)
     (log/info "\n-=[simple-clojure started successfully using the development profile]=-"))
   :stop
   (fn []
     (log/info "\n-=[simple-clojure has shut down successfully]=-"))
   :middleware wrap-dev})
