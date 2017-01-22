{-
 Convenience functions for Http verbs not covered in the Elm Http package
 Not needed when using Servant generated interface code.
-}
module Util.Http.Methods exposing (..)

import Http
import Json.Decode as Json
import Json.Encode as Encode


-- 
-- Http package does not have these --
-- or more convenient versions  
--                                --
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
  
