module Util.Logger exposing (..)

import Html exposing (Html)
import Html.App as Html

type alias LoggerConfig = {
    on: Bool
  , logUpdateOn: Bool
  , logViewOn: Bool
  , logInitOn: Bool
  , logNavOn: Bool
  , logNavLocOn: Bool -- like Nav model
  , logMsgOn: Bool
  , logModelOn: Bool
  , logInputOn: Bool
  , logOutputOn: Bool
  , logHtmlOn: Bool
  , logSubOn: Bool
  , logFlagsOn: Bool
}
 
--
-- For static use, not used with programWithFlags
--
defaultConfig : LoggerConfig
defaultConfig = {
   on = True
  , logUpdateOn = True
  , logViewOn = False
  , logInitOn = True
  , logNavOn = False
  , logNavLocOn = True -- like Nav model
  , logMsgOn = True
  , logModelOn = True
  , logInputOn = True
  , logOutputOn = True
  , logHtmlOn = False
  , logSubOn = False
  , logFlagsOn = True
 }

--
-- TODO try to rethink this, this version is kinda ugly
--

logModel : LoggerConfig -> String -> model -> model
logModel config logMsg = 
      logIfOn config.logModelOn (logMsg ++ ":model")

logMsg : LoggerConfig -> String -> msg -> msg
logMsg config logMsg = 
      logIfOn config.logMsgOn (logMsg ++ ":msg")


logNavLoc : LoggerConfig -> String -> data -> data
logNavLoc config logMsg = 
      logIfOn config.logNavLocOn (logMsg ++ ":navL")


logFlags : LoggerConfig -> String -> flags -> flags
logFlags config logMsg = 
      logIfOn config.logFlagsOn (logMsg ++ ":flags")

logModelAndCmd : LoggerConfig -> String -> (model, Cmd msg) -> (model, Cmd msg)
logModelAndCmd config txt (model, cmd) = 
          (logModel config txt model, Cmd.map (logMsg config txt) cmd)


logHtml : LoggerConfig -> String -> Html msg -> Html msg
logHtml config txt html = 
          if config.logHtmlOn 
          then Debug.log (txt ++ ":html") html
          else Html.map (Debug.log (txt ++ ":html.msg")) html  -- traces user triggered outgoing Msg

--
--  would that be more elegant with (Function.map << Function.map) or (<<) << (<<) (return side)
--
updateWithLogging : (model -> LoggerConfig) -> String -> (msg -> model -> (model, Cmd msg)) -> msg -> model -> (model, Cmd msg)
updateWithLogging configF txt_ = 
        let txt = txt_ ++ ":update" 
            logic updateF = 
               (\msg model -> 
                 let config = configF model 
                 in if config.on && config.logUpdateOn
                    then logicIfOn config.logOutputOn (logModelAndCmd config (txt ++ ":out" )) 
                       <| updateF (logicIfOn config.logInputOn (logMsg config (txt ++ ":in")) msg) (logicIfOn config.logInputOn (logModel config (txt ++ ":in")) model)
                    else updateF msg model)
        in logic 

viewWithLogging : (model -> LoggerConfig) ->  String -> (model -> Html msg) -> model -> Html msg
viewWithLogging configF txt_ = 
        let  txt = txt_ ++ ":view" 
             logic viewF = (\model ->
                 let config = configF model 
                 in if config.on && config.logViewOn
                    then logicIfOn config.logOutputOn (logHtml config (txt ++ ":out" )) 
                            <| viewF 
                            <| logicIfOn config.logInputOn (logModel config (txt ++ ":in")) model 
                    else viewF model ) 
        in logic 
        

-- init : Logic.RouteData -> (Model, Cmd Msg)
navInitWithLogging : (flags -> LoggerConfig) -> String -> (flags -> loc -> (model, Cmd msg)) -> flags -> loc -> (model, Cmd msg)
navInitWithLogging configF txt_ = 
        let txt = txt_ ++ ":init" 
            logic initF = 
                (\flags loc -> 
                   let config = configF flags
                   in if config.on && config.logInitOn
                      then logicIfOn config.logOutputOn (logModelAndCmd config (txt ++ ":out" )) 
                                 <| initF (logicIfOn config.logFlagsOn (logFlags config (txt ++ ":in")) flags) (logicIfOn config.logInputOn (logNavLoc config (txt ++ ":in")) loc)
                      else initF flags loc
                 )
        in logic 

navUpdateWithLogging : (model -> LoggerConfig) -> String -> (data -> model -> (model, Cmd msg)) -> data -> model -> (model, Cmd msg)
navUpdateWithLogging configF txt_ = 
        let txt = txt_ ++ ":urlUpdate" 
            logic updateF = (\msg model -> 
                   let config = configF model
                   in if config.on && config.logNavOn
                      then logicIfOn config.logOutputOn (logModelAndCmd config (txt ++ ":out" )) 
                              <| updateF (logicIfOn config.logInputOn (logNavLoc config (txt ++ ":in")) msg) (logicIfOn config.logInputOn (logModel config (txt ++ ":in")) model)
                      else updateF msg model )
        in logic 

subWithLoging : (model -> LoggerConfig) -> String -> (model -> Sub msg) -> model -> Sub msg
subWithLoging configF txt_ = 
        let  txt = txt_ ++ ":sub" 
             logic subF = (\model ->
                   let config = configF model
                   in if config.on && config.logSubOn
                      then logicIfOn config.logOutputOn (Sub.map (Debug.log (txt ++ ".msg"))) 
                            <| subF 
                            <| logicIfOn config.logInputOn (logModel config (txt ++ ":in")) model
                      else subF model
                ) 
        in logic 

------
-- PRIVATE HELPERS (TODO do not export)
------

logicIfOn : Bool -> (a -> a) -> a -> a 
logicIfOn on logic x = 
        if not on
        then x
        else logic x

--
-- NOTE logIfOn on msg = logicIfOn on (Debug.log msg)
--
logIfOn : Bool -> String -> a -> a
logIfOn on logMsg x = 
    if not on
    then x
    else Debug.log logMsg x
