module Reuse.Http exposing (..)

import Task exposing (Task)
import Http
import Json.Decode as Json
import Json.Encode as Encode

-- used in defining reusable messages --
type HttpPUT = HttpPUT  
type HttpGET = HttpGET 
type HttpPOST = HttpPOST
type HttpPATCH = HttpPATCH
type HttpDELETE = HttpDELETE

type HttpRes method model = 
       HttpResOk method model |
       HttpResErr method String Http.Error


-- Http methods implemented if Http library does not have these --
-- or more convenient versions                                  --
put : Json.Decoder value -> String -> Encode.Value -> Task Http.Error value
put decoder url encoder =
  let request =
        { verb = "PUT"
        , headers = [
                 ("Origin", "http://localhost:8000/"),
                 ("Content-Type", "application/json; charset=UTF-8")
        ]
        , url = url
        , body = Http.string <| Encode.encode 0 encoder
        }
  in
      Http.fromJson decoder (Http.send Http.defaultSettings request)

post : Json.Decoder value -> String -> Encode.Value -> Task Http.Error value
post decoder url encoder =
    Http.post decoder url (Http.string <| Encode.encode 0 encoder)

delete :  String ->  Task Http.Error ()
delete url =
  let request =
        { verb = "DELETE"
        , headers = [("Content-Type", "application/json; charset=UTF-8")]
        , url = url
        , body = Http.empty
        }
  in
      Http.fromJson (Json.succeed ()) (Http.send Http.defaultSettings request)
  
