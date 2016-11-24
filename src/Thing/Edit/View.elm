module Thing.Edit.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Thing.Edit.Logic as Logic
import Reuse.Edit.View as ViewS
import Reuse.Edit.Message as MsgS 


view : Logic.Model -> Html Logic.Msg
view model =
  div [] [
   div []
    [ input [ type' "text", value model.model.name, onInput <| MsgS.InnerMsg << Logic.NameChange  ] []
    ],
   div []
    [ input [ type' "text", value model.model.description, onInput <| MsgS.InnerMsg << Logic.DescriptionChange ] []
    ],
   ViewS.viewButtons model,
   ViewS.viewError model
  ] 
