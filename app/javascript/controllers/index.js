// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import CatchesAnimalsController from "./catches_animals_controller"
application.register("catches-animals", CatchesAnimalsController)

import HomeController from "./home_controller"
application.register("home", HomeController)

import IndexCollectionController from "./index_collection_controller"
application.register("index-collection", IndexCollectionController)

import ShowCollectionController from "./show_collection_controller"
application.register("show-collection", ShowCollectionController)
