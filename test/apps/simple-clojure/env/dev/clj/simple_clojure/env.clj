(ns simple_clojure.env
  (:require [selmer.parser :as parser]
            [clojure.tools.logging :as log]
            [simple_clojure.dev-middleware :refer [wrap-dev]]))

(def defaults
  {:init
   (fn []
     (parser/cache-off!)
     (log/info "\n-=[simple_clojure started successfully using the development profile]=-"))
   :stop
   (fn []
     (log/info "\n-=[simple_clojure has shut down successfully]=-"))
   :middleware wrap-dev})
