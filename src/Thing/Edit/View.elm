module Thing.Edit.View exposing (..)

import Html as Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Thing.Model exposing (Thing)
import Thing.Edit.Logic as Logic
import Reuse.Edit.View as ViewS
import Reuse.Edit.Message as MsgS 
import Reuse.Common.Styles as DefStyle

--
-- NOTE desing miminizes styling decisions on the entity level
-- 

viewThing : Thing -> List(String, Html Logic.Msg)
viewThing thing =
  [
    (
      "Name", 
      input (DefStyle.textInputDefault ++ [ type_ "text", value thing.name, onInput <| MsgS.InnerMsg << Logic.NameChange]) []
    ),
    (
      "Description", 
      textarea (DefStyle.textAreaDefault ++  [value thing.description, onInput <| MsgS.InnerMsg << Logic.DescriptionChange ]) []
    )
  ] 

view : Logic.Model -> Html Logic.Msg
view = ViewS.viewReuse viewThing 
