module App.Main exposing (..)

--import Navigation as Nav
import App.Model exposing (Model, AppFlags, initModel, getLoggerConfig, appFlagsToLoggerConfig)
import App.Message exposing (Msg)
import App.View exposing (view)
import App.Logic as Logic
import Util.CmdExtras as CmdE
import Util.Logger as Logger
import Util.Logger.NavProgram as Program

init : AppFlags -> Logic.RouteData -> (Model, Cmd Msg)
init appFlags data = (initModel appFlags, CmdE.pure <| Logic.resolveParsedRoute data)
 
-- main : Program Never Model Msg
main =
    Program.programWithFlags Logic.routeParser
        { flagsToLoggerConf = appFlagsToLoggerConfig
        , modelToLoggerConf = getLoggerConfig
        , init = init
        , view =  view
        , update = Logic.update
        , urlUpdate = Logic.urlUpdate
        , subscriptions = always Sub.none
        }
