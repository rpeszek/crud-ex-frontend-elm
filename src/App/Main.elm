module App.Main exposing (..)

--import Navigation as Nav
import App.Model exposing (Model, AppFlags, initModel, getLoggerConfig, appFlagsToLoggerConfig)
import App.Message exposing (Msg)
import App.View exposing (view)
import App.Logic as Logic
import Navigation as Nav
import Util.CmdExtras as CmdE
import Util.Logger as Logger
import Util.Logger.NavProgram as Program

init : AppFlags -> Nav.Location -> (Model, Cmd Msg)
init appFlags location = (initModel appFlags, CmdE.pure <| Logic.resolveLocation location)

-- main : Program Never Model Msg
main =
    Program.programWithFlags 
       { 
          locationToLoggerConf = always Logger.navLoggerConf  --TODO
        , flagsToLoggerConf = appFlagsToLoggerConfig
        , modelToLoggerConf = getLoggerConfig
        , init = init
        , view =  view
        , update = Logic.update
        , urlUpdate = Logic.resolveLocation
        , subscriptions = always Sub.none
        }
