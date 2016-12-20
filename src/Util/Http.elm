module Util.Http exposing (..)

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

type HttpRes method value = 
       HttpResOk method value |
       HttpResErr method String Http.Error

--send : (Result Error a -> msg) -> Request a -> Cmd msg
-- Cmd (HttpS.HttpRes HttpS.HttpGET Model.Thing)

resultConverter  : method -> String -> Result Http.Error value -> HttpRes method value
resultConverter method errMsg res = case res of
       Ok val -> HttpResOk method val
       Err err -> HttpResErr method errMsg err

-- TODO decoder moves to last postion
-- Http methods implemented if Http library does not have these --
-- or more convenient versions                                  --
put : String -> Encode.Value -> Json.Decoder value -> Http.Request value
put url encoder decoder =
    let requestParams = {   
              method = "PUT"
            , headers = [
                     Http.header "Content-Type" "application/json; charset=UTF-8"
            ]
            , url = url
            , body = Http.jsonBody encoder
            , expect = Http.expectJson decoder
            , timeout = Nothing 
            , withCredentials = False
        }
   in
      Http.request <| requestParams

post : String -> Encode.Value -> Json.Decoder value -> Http.Request value
post url encoder decoder =
    Http.post url (Http.jsonBody encoder) decoder

delete :  String ->  Http.Request ()
delete url = 
  let requestParams =
    {   
          method = "DELETE"
        , headers = [
                 Http.header "Content-Type" "application/json; charset=UTF-8"
        ]
        , url = url
        , body = Http.emptyBody 
        , expect = Http.expectStringResponse (\_ -> Ok ())
        , timeout = Nothing 
        , withCredentials = False
    }
  in
      Http.request <| requestParams
  
