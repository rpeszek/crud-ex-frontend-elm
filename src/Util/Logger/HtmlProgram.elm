module Util.Logger.HtmlProgram exposing (..)
 
import Html as Html exposing (Html)
import Util.Logger exposing (..)


type alias ProgramLogic model msg = 
 { 
    loggerConf : LoggerConfig
  , init : (model, Cmd msg) 
  , update : msg -> model -> (model, Cmd msg) 
  , subscriptions : model -> Sub msg 
  , view : model -> Html msg }
 
program : ProgramLogic model msg -> Program Never model msg
program logic = Html.program {
     init = log1 Std LInit (always logic.loggerConf) describeOutputModelAndCmd 
                  <| logic.init    
   , update = log3b Std LUpdate (always logic.loggerConf) (describeInput LModel) (describeInput LMsg) describeOutputModelAndCmd
                  <| logic.update
   , view = log2 Std LView (always logic.loggerConf) (describeInput LModel) describeOutputHtml 
                  <| logic.view
   , subscriptions = log2 Std LSub (always logic.loggerConf) (describeInput LModel) describeOutputSubscription
                   <| logic.subscriptions
 }
