module App.Model exposing (..)

import Thing.Combined.Logic as ThingModule
import Routing.Logic as RoutingModule
import Routing.ElmRoute exposing (ElmRoute)

type alias Model = {
    routeM : RoutingModule.Model
  , thingM : ThingModule.Model } 

setRoute : ElmRoute -> Model -> Model 
setRoute route model = {model | routeM = RoutingModule.setRoute route model.routeM}

setRouteErr : String -> Model -> Model 
setRouteErr url model = {model | routeM = RoutingModule.setErr url model.routeM}

setThingM : ThingModule.Model -> Model -> Model 
setThingM thingM model = {model | thingM = thingM}

initModel : Model
initModel = {routeM = RoutingModule.initModel, thingM = ThingModule.initModel}
