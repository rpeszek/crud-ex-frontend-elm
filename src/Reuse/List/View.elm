module Reuse.List.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Reuse.Model.ModelEntity as ModelS
import Reuse.Common.View as ViewC
import Reuse.List.Message as MsgS
import Reuse.Common.Styles as DefStyle

viewReuse : (model -> Html (MsgS.ListMsg model msg)) -> ModelS.ModelEntityList model -> Html (MsgS.ListMsg model msg)
viewReuse elementView listModel = 
   div [] [
     viewError listModel , 
     div[] <| List.map (viewListElement elementView) listModel.elements ,
     div DefStyle.buttonSet [button (DefStyle.buttonPrimary ++ [onClick <| MsgS.CreateRequest]) [text "Create New"]]
   ] 
  
viewListElement : (model -> Html (MsgS.ListMsg model msg)) -> ModelS.ModelEntity model -> Html (MsgS.ListMsg model msg)
viewListElement elementView element =
     div DefStyle.listElement [
         elementView element.entity
         , a (DefStyle.listElementLink ++ [onClick <| MsgS.ViewRequest element.id]) [text "(view)"]
     ]   

-- TODO generalize (this is same as in common)
viewError : ModelS.ModelEntityList model -> Html msg
viewError model =
    case model.err of
       Just (txt, _) -> 
          ViewC.viewErrorTxt txt
       Nothing -> 
          div [] []
