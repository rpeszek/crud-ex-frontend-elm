module Thing.Read.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Reuse.Read.View as ViewS
import Reuse.Read.Message as MsgS 
import Reuse.Model.ModelPlus as ModelS
import Thing.Read.Logic as Logic
import Reuse.Common.Styles as DefStyle

view : Logic.Model -> Html Logic.Msg
view model =
  div DefStyle.readGrid [
   div DefStyle.readLabel
    [ text "Name:"
    ],
   div DefStyle.readContent
    [ text model.model.name
    ],
   div DefStyle.readLabel
    [ text "Description:"
    ],
   div DefStyle.readLongContent
    [ text model.model.description
    ],
    ViewS.viewError model,
    ViewS.viewButtons model
  ] 
