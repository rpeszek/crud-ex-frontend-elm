module Reuse.Common.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Reuse.Model.ModelPlus as ModelS
import Reuse.Common.Styles as DefStyle

viewError : ModelS.ModelPlus model -> Html msg
viewError model =
    case model.err of
       Just (txt, _) -> 
          viewErrorTxt txt
       Nothing -> 
          div [] []


viewErrorTxt : String -> Html msg
viewErrorTxt txt =
        div DefStyle.errorBox [ text txt ]
