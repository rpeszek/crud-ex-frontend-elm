module Util.Http exposing (..)

import Task exposing (Task)
import Http
import Json.Decode as Json
import Json.Encode as Encode

type HttpPUT = HttpPUT  
type HttpGET = HttpGET 
type HttpPOST = HttpPOST
type HttpPATCH = HttpPATCH
type HttpDELETE = HttpDELETE

type HttpRes method value = 
       HttpResOk method value |
       HttpResErr method String Http.Error

resultConverter  : method -> String -> Result Http.Error value -> HttpRes method value
resultConverter method errMsg res = case res of
       Ok val -> HttpResOk method val
       Err err -> HttpResErr method errMsg err
