module Thing.Edit.View exposing (..)

import Html as Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Thing.Edit.Logic as Logic
import Reuse.Edit.View as ViewS
import Reuse.Edit.Message as MsgS 
import Reuse.Common.Styles as DefStyle


view : Logic.Model -> Html Logic.Msg
view model =
  Html.form DefStyle.formDefault [
   Html.fieldset [] [
   div DefStyle.formRowDefault
    [ label [] [text "Name"],
      input (DefStyle.textInputDefault ++ [ type' "text", value model.model.name, onInput <| MsgS.InnerMsg << Logic.NameChange]) []
    ],
   div DefStyle.formRowDefault
    [ label [] [text "Description"],
      textarea (DefStyle.textAreaDefault ++  [value model.model.description, onInput <| MsgS.InnerMsg << Logic.DescriptionChange ]) []
    ],
   ViewS.viewButtons model,
   ViewS.viewError model
   ]
  ] 
