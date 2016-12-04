module Util.Logger.HtmlProgram exposing (..)
 
import Html.App as Html
import Util.Logger exposing (..)
import Html exposing (Html)


type alias ProgramLogic model msg = 
 { 
    loggerConf : LoggerConfig
  , init : (model, Cmd msg) 
  , update : msg -> model -> (model, Cmd msg) 
  , subscriptions : model -> Sub msg 
  , view : model -> Html msg }
 
program : ProgramLogic model msg -> Program Never
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
