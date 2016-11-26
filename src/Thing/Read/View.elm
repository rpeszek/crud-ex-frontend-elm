module Thing.Read.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Thing.Model exposing (Thing)
import Reuse.Read.View as ViewS
import Reuse.Read.Message as MsgS 
import Reuse.Model.ModelPlus as ModelS
import Thing.Read.Logic as Logic
import Reuse.Common.Styles as DefStyle
 
viewThing : Thing -> List (String, Html Logic.Msg)
viewThing thing = 
  [
      ("Name:", div DefStyle.readContent [ text thing.name ])
    , ("Description:", div DefStyle.readLongContent [ text thing.description])
  ] 

view : Logic.Model -> Html Logic.Msg
view = ViewS.viewReuse viewThing
