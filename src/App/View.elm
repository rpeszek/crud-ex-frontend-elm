module App.View exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import App.Message as App 
import App.Model as App
import Routing.View as Routing
import Thing.Combined.View as Thing


view : App.Model -> Html App.Msg
view model = 
     div[] [
          Html.map App.RoutingModuleMsg <| Routing.view model.routeM
        , Html.map App.ThingModuleMsg   <| Thing.viewForRoute model.routeM.route model.thingM 
      ]
