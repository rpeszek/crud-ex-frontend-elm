module Util.Logger.NavProgram exposing (..)

import Util.Logger exposing (..)
import Navigation as Nav
import Html exposing (Html)


type alias ProgramLogic flags data model msg = 
 { 
    modelToLoggerConf : model -> LoggerConfig
  , flagsToLoggerConf : flags -> LoggerConfig
  , init : flags -> data -> (model, Cmd msg)
  , update : msg -> model -> (model, Cmd msg)
  , urlUpdate : data -> model -> (model, Cmd msg)
  , view : model -> Html msg
  , subscriptions : model -> Sub msg }


programWithFlags :  Nav.Parser data
    -> ProgramLogic flags data model msg
    -> Program flags
programWithFlags parser logic = Nav.programWithFlags parser
    {  init = navInitWithLogging logic.flagsToLoggerConf "app" logic.init
      , view = viewWithLogging logic.modelToLoggerConf "app" logic.view
      , update = updateWithLogging logic.modelToLoggerConf "app" logic.update
      , urlUpdate = navUpdateWithLogging logic.modelToLoggerConf "app" logic.urlUpdate
      , subscriptions = subWithLoging logic.modelToLoggerConf "app" logic.subscriptions
     }
