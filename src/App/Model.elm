module App.Model exposing (..)

import Thing.Combined.Logic as ThingModule
import Routing.Logic as RoutingModule
import ElmRoutes exposing (ElmRoute)
import Util.Logger as Logger

type alias AppConfig = {
    logConfig : Logger.LoggerConfig
  , layout : String
 }

initAppConfig : AppConfig 
initAppConfig = {
    logConfig = Logger.defaultConfig
  , layout = "TODO"
 }

appConfigToLoggerConfig : AppConfig -> Logger.LoggerConfig
appConfigToLoggerConfig m = m.logConfig

type alias Model = {
    appConfigM : AppConfig
  , routeM : RoutingModule.Model
  , thingM : ThingModule.Model } 

setRoute : ElmRoute -> Model -> Model 
setRoute route model = {model | routeM = RoutingModule.setRoute route model.routeM}

setRouteErr : String -> Model -> Model 
setRouteErr url model = {model | routeM = RoutingModule.setErr url model.routeM}

setThingM : ThingModule.Model -> Model -> Model 
setThingM thingM model = {model | thingM = thingM}

setAppConfig : AppConfig -> Model -> Model 
setAppConfig appConf model = {model | appConfigM = appConf}

initModel : AppConfig -> Model
initModel appConfig = {appConfigM = appConfig, routeM = RoutingModule.initModel, thingM = ThingModule.initModel}

getLoggerConfig : Model -> Logger.LoggerConfig
getLoggerConfig model = model.appConfigM.logConfig
