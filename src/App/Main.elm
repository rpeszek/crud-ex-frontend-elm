module App.Main exposing (..)

import Navigation as Nav
import App.Model exposing (Model, initModel)
import App.Message exposing (Msg)
import App.View exposing (view)
import App.Logic as Logic
import Reuse.CmdExtras as CmdE

init : Logic.RouteData -> (Model, Cmd Msg)
init data = (initModel, CmdE.pure <| Logic.resolveParsedRoute <| Debug.log "Init" data)
 
-- main : Program Never Model Msg
main =
    Nav.program Logic.routeParser
        { init = init
        , view = view
        , update = Logic.update
        , urlUpdate = Logic.urlUpdate
        , subscriptions = always Sub.none
        }
