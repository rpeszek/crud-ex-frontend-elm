module Reuse.Common.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Reuse.Model.ModelPlus as ModelS

viewError : ModelS.ModelPlus model -> Html msg
viewError model =
    case model.err of
       Just (txt, _) -> 
          div [ style [("color", "red")] ] [ text txt ]
       Nothing -> 
          div [] []
