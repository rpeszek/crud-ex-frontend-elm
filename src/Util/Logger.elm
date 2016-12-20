module Util.Logger exposing (..)

import Html as Html exposing (Html)
import String

type LoggerFlag = 
     LApp 
   | LIn 
   | LOut 
   | LUpdate
   | LView
   | LInit 
   | LNav 
   | LMsg 
   | LModel 
   | LNavLoc  -- like Nav model
   | LHtml 
   | LSub 
   | LFlags 

type LoggerLevel = 
      Info
    | Std
    | Crit
   
type alias LoggerConfig = {
    logLevel : LoggerLevel
  , logFlags : List LoggerFlag
 }

navLoggerConf : LoggerConfig
navLoggerConf = {
    logLevel = Std
  , logFlags = [LApp, LNav, LOut, LIn, LNavLoc, LMsg] 
 }

defaultLoggerConf : LoggerConfig
defaultLoggerConf = {
    logLevel = Std
  , logFlags = [LApp, LInit, LOut, LIn] 
 }

testLoggerConf : LoggerConfig
testLoggerConf = {
    logLevel = Info
  , logFlags = [LApp, LInit, LUpdate, LOut, LIn, LMsg, LModel]  
 }

levelToInt : LoggerLevel -> Int 
levelToInt level = case level of
      Info -> 1
      Std  -> 2
      Crit -> 3

--
-- Logger components
--

describeElement : List LoggerFlag -> List LoggerFlag -> LoggerConfig -> a -> a 
describeElement logFlags_ stack config = 
               if shouldLogItem logFlags_ config 
               then Debug.log (logMsgP <| logFlags_ ++ stack)
               else identity

describeInput : LoggerFlag -> List LoggerFlag -> LoggerConfig -> a -> a 
describeInput flag = describeElement [flag, LIn] 

describeOutput : LoggerFlag -> List LoggerFlag -> LoggerConfig -> a -> a 
describeOutput flag = describeElement [flag, LOut] 

describeOutputModelAndCmd :  List LoggerFlag -> LoggerConfig -> (model, Cmd msg) -> (model, Cmd msg)
describeOutputModelAndCmd stack config (model, cmd) = 
        let logFlags_ = [LOut]
        in if shouldLogItem logFlags_ config 
           then let allFlags = (logFlags_ ++ stack)
                in (describeElement [LModel] allFlags config model, Cmd.map (describeElement [LMsg] allFlags config) cmd)
           else (model, cmd)

describeOutputSubscription : List LoggerFlag -> LoggerConfig -> Sub msg -> Sub msg
describeOutputSubscription  stack config sub = 
        let logFlags_ = [LOut]
        in if shouldLogItem logFlags_ config
           then let allFlags = (logFlags_ ++ stack)
                in Sub.map (describeElement [LSub] allFlags config) sub 
           else sub

describeOutputHtml : List LoggerFlag -> LoggerConfig -> Html msg -> Html msg
describeOutputHtml stack config sub = 
        let logFlags_ = [LOut]
        in if shouldLogItem logFlags_ config
           then let allFlags = (logFlags_ ++ stack)
                in Html.map (describeElement [LSub] allFlags config) sub 
           else sub

--
-- Logger Combinators
--
-- NOTE: 
-- These are intended to be used on 'top level' so no stack input param
--
log1 : LoggerLevel -> LoggerFlag -> (a -> LoggerConfig) -> (List LoggerFlag -> LoggerConfig -> a -> a) -> a -> a
log1 level flag configF aWithLog a =
            let logFlags_ = [flag, LApp]
                config = configF a 
            in if shouldLogLevel level config && shouldLogItem logFlags_ config 
               then Debug.log (logMsgP logFlags_) a 
               else a

log2: LoggerLevel -> LoggerFlag -> (a -> LoggerConfig) -> (List LoggerFlag -> LoggerConfig -> a -> a) -> (List LoggerFlag -> LoggerConfig -> b -> b) -> (a -> b) -> a -> b
log2 level flag configF aWithLog bWithLog fn = 
           (\a -> 
                let logFlags_ = [flag, LApp]
                    config = configF a 
                in if shouldLogLevel level config && shouldLogItem logFlags_ config  
                   then bWithLog logFlags_ config <| fn <| aWithLog logFlags_ config <| a
                   else fn a
            )

log3a: LoggerLevel -> 
     LoggerFlag -> 
     (a -> LoggerConfig) -> 
     (List LoggerFlag -> LoggerConfig -> a -> a) -> 
     (List LoggerFlag -> LoggerConfig -> b -> b) -> 
     (List LoggerFlag -> LoggerConfig -> c -> c) -> 
     (a -> b -> c) -> a -> b -> c
log3a level flag configF aWithLog bWithLog cWithLog fn a = 
              let logFlags_ = [flag, LApp]
                  config = configF a
                  aLogged = if shouldLogLevel level config && shouldLogItem logFlags_ config 
                            then aWithLog logFlags_ config a
                            else a
              in log2 level flag (always config) bWithLog cWithLog (fn aLogged)


log3b: LoggerLevel -> 
     LoggerFlag -> 
     (b -> LoggerConfig) -> 
     (List LoggerFlag -> LoggerConfig -> a -> a) -> 
     (List LoggerFlag -> LoggerConfig -> b -> b) -> 
     (List LoggerFlag -> LoggerConfig -> c -> c) -> 
     (a -> b -> c) -> a -> b -> c
log3b level flag configF aWithLog bWithLog cWithLog fn = 
     flip <| log3a level flag configF bWithLog aWithLog cWithLog (flip fn)


--
-- Implemenation helpers 
--
shouldLogLevel : LoggerLevel -> LoggerConfig -> Bool
shouldLogLevel level config = levelToInt level >= levelToInt config.logLevel

shouldLogItem : List LoggerFlag -> LoggerConfig -> Bool
shouldLogItem logFlags_ config = List.all (\it -> List.member it config.logFlags) logFlags_

loggerFlagDisplay : LoggerFlag -> String
loggerFlagDisplay = String.dropLeft 1 << toString

logMsgP : List LoggerFlag -> String
logMsgP stack = case stack of
         [] -> ""
         (x::xs) -> logMsgP xs ++ ":" ++ loggerFlagDisplay x
