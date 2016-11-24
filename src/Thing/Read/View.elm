module Thing.Read.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Reuse.Read.View as ViewS
import Reuse.Read.Message as MsgS 
import Reuse.Model.ModelPlus as ModelS
import Thing.Read.Logic as Logic

view : Logic.Model -> Html Logic.Msg
view model =
  div [] [
   div []
    [ text model.model.name
    ],
   div []
    [ text model.model.description
    ],
    ViewS.viewButtons model,
    ViewS.viewError model
  ] 
