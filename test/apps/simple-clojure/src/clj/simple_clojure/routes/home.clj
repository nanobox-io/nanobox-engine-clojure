(ns simple-clojure.routes.home
  (:require [simple-clojure.layout :as layout]
            [compojure.core :refer [defroutes GET]]
            [ring.util.http-response :as response]
            [clojure.java.io :as io]))

(defn home-page []
  (layout/render "hello.html"))

(defroutes home-routes
  (GET "/" [] (home-page)))

