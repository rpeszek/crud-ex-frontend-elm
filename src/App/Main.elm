module App.Main exposing (..)

--import Navigation as Nav
import App.Model exposing (Model, AppConfig, initModel, getLoggerConfig, appConfigToLoggerConfig)
import App.Message exposing (Msg)
import App.View exposing (view)
import App.Logic as Logic
import Reuse.CmdExtras as CmdE
import Util.Logger as Logger
import Util.Logger.NavProgram as Program

init : AppConfig -> Logic.RouteData -> (Model, Cmd Msg)
init appConf data = (initModel appConf, CmdE.pure <| Logic.resolveParsedRoute data)
 
-- main : Program Never Model Msg
main =
    Program.programWithFlags Logic.routeParser
        { flagsToLoggerConf = appConfigToLoggerConfig
        , modelToLoggerConf = getLoggerConfig
        , init = init
        , view =  view
        , update = Logic.update
        , urlUpdate = Logic.urlUpdate
        , subscriptions = always Sub.none
        }
