module Sanity exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, classList)
import Pure

presentList : List String -> Html msg
presentList listTxt = ul [class Pure.grid] (List.map (\txt -> div [classList [(Pure.unit ["1","1"], True), ("l-box", True)]] [button [class "pure-button pure-button-primary"] [text txt]]) listTxt)

main = presentList ["red", "green", "blue", "black"]
