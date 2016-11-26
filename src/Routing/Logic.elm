module Routing.Logic exposing (..)

import Routing.ElmRoute as ElmRoute

type alias Model = {
    route : ElmRoute.ElmRoute  -- defaulted if error
  , err : Maybe String
}

-- TODO add RouteRequestMsg 
type Msg = 
     RouteMsg ElmRoute.ElmRoute
   | UnknownRouteMsg String

setRoute : ElmRoute.ElmRoute -> Model -> Model
setRoute route model = {model | route = route, err = Nothing}

setErr : String -> Model -> Model
setErr url model = {model | route = ElmRoute.defaultRoute, err = Just <| "Invalid URL " ++ url}

getRoute : Model -> ElmRoute.ElmRoute 
getRoute model = model.route 

initModel : Model
initModel = {route = ElmRoute.defaultRoute, err = Nothing}
