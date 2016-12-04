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
    {  init = log3a Std LInit logic.flagsToLoggerConf (describeInput LFlags) (describeInput LNavLoc) describeOutputModelAndCmd
                   <| logic.init
      , view = log2 Std LView logic.modelToLoggerConf (describeInput LModel) describeOutputHtml 
                   <| logic.view
      , update = log3b Std LUpdate logic.modelToLoggerConf (describeInput LModel) (describeInput LMsg) describeOutputModelAndCmd
                   <| logic.update
      , urlUpdate = log3b Std LNav logic.modelToLoggerConf (describeInput LNavLoc) (describeInput LModel) describeOutputModelAndCmd
                   <| logic.urlUpdate
      , subscriptions = log2 Std LSub logic.modelToLoggerConf (describeInput LModel) describeOutputSubscription
                   <| logic.subscriptions
     }
