module Util.Logger.Json exposing (loggerConfigDecoder)

import Json.Decode as Json
import Util.Logger exposing (..)

loggerFlagDecoder : String -> Json.Decoder LoggerFlag
loggerFlagDecoder tag = case tag of
      "LApp"    -> Json.succeed LApp
      "LIn"     -> Json.succeed LIn
      "LOut"    -> Json.succeed LOut
      "LUpdate" -> Json.succeed LUpdate
      "LView"   -> Json.succeed LView
      "LInit"   -> Json.succeed LInit
      "LNav"    -> Json.succeed LNav
      "LMsg"    -> Json.succeed LMsg
      "LModel"  -> Json.succeed LModel
      "LNavLoc" -> Json.succeed LNavLoc
      "LHtml"   -> Json.succeed LHtml
      "LSub"    -> Json.succeed LSub
      "LFlags"  -> Json.succeed LFlags
      _ -> Json.fail (tag ++ " is not a recognized tag for LoggerFlag")


loggerLevelDecoder : String -> Json.Decoder LoggerLevel
loggerLevelDecoder tag = case tag of
      "Info" -> Json.succeed Info
      "Std" -> Json.succeed Std
      "Crit" -> Json.succeed Crit
      _ -> Json.fail (tag ++ " is not a recognized tag for LoggerLevel")

loggerConfigDecoder : Json.Decoder LoggerConfig
loggerConfigDecoder =  Json.map2 LoggerConfig
    (Json.field "logLevel" (Json.string |> Json.andThen loggerLevelDecoder))
    (Json.field "logFlags" (Json.list (Json.string |> Json.andThen loggerFlagDecoder)))
