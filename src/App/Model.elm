module App.Model exposing (..)

import Thing.Combined.Logic as ThingModule
import Routing.Logic as RoutingModule
import ElmRoutes exposing (ElmRoute)
import Util.Logger as Logger
import Util.Logger.Json as LoggerJson
import Json.Decode as Json

type alias AppConfig = {
    logConfig : Logger.LoggerConfig
  , layout : String
 }

type alias AppFlags = {
    logConfig : Json.Value
  , layout : String
 }

initAppConfig : AppConfig 
initAppConfig = {
    logConfig = Logger.defaultLoggerConf
  , layout = "TODO"
 }

appFlagsToLoggerConfig : AppFlags -> Logger.LoggerConfig
appFlagsToLoggerConfig flags = 
    let result = Json.decodeValue LoggerJson.loggerConfigDecoder flags.logConfig
    in case result of 
       Ok config ->  config
       Err msg   ->  Debug.log ("Error Parsing Flags" ++ msg) Logger.defaultLoggerConf
     

appFlagsToAppConfig : AppFlags -> AppConfig
appFlagsToAppConfig flags = {logConfig = appFlagsToLoggerConfig flags, layout = flags.layout} 

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

initModel : AppFlags -> Model
initModel appFlags = {appConfigM = appFlagsToAppConfig appFlags, routeM = RoutingModule.initModel, thingM = ThingModule.initModel}

getLoggerConfig : Model -> Logger.LoggerConfig
getLoggerConfig model = model.appConfigM.logConfig
