module Util.Logger.NavProgram exposing (..)

import Util.Logger exposing (..)
import Navigation as Nav
import Html exposing (Html)

--    :  (Location -> msg)
--    -> { init : flags -> Location -> (model, Cmd msg), update : msg -> model -> (model, Cmd msg), view : model -> Html msg, subscriptions : model -> Sub msg }
--    -> Program flags model msg

type alias ProgramLogic flags model msg = 
 { 
    locationToLoggerConf : Nav.Location -> LoggerConfig
  , modelToLoggerConf : model -> LoggerConfig
  , flagsToLoggerConf : flags -> LoggerConfig
  , init : flags -> Nav.Location -> (model, Cmd msg)
  , update : msg -> model -> (model, Cmd msg)
  , urlUpdate : Nav.Location -> msg
  , view : model -> Html msg
  , subscriptions : model -> Sub msg }


programWithFlags : ProgramLogic flags model msg -> Program flags model msg
programWithFlags logic = Nav.programWithFlags 
    (log2 Std LNav logic.locationToLoggerConf (describeInput LNavLoc) (describeOutput LMsg) <| logic.urlUpdate)
    {  init = log3a Std LInit logic.flagsToLoggerConf (describeInput LFlags) (describeInput LNavLoc) describeOutputModelAndCmd
                   <| logic.init
      , view = log2 Std LView logic.modelToLoggerConf (describeInput LModel) describeOutputHtml 
                   <| logic.view
      , update = log3b Std LUpdate logic.modelToLoggerConf (describeInput LModel) (describeInput LMsg) describeOutputModelAndCmd
                   <| logic.update
      , subscriptions = log2 Std LSub logic.modelToLoggerConf (describeInput LModel) describeOutputSubscription
                   <| logic.subscriptions
     }
