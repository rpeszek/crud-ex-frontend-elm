module Thing.List.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Reuse.List.View as ViewS
import Reuse.List.Message as MsgS 
import Reuse.Model.ModelPlus as ModelS
import Thing.List.Logic as Logic
import Thing.Model exposing (Thing)


view : Logic.Model -> Html Logic.Msg
view = ViewS.viewList viewThing


viewThing : Thing -> Html msg
viewThing thing = 
     div[] [text thing.name]
