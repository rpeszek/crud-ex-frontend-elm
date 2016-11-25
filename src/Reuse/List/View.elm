module Reuse.List.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Reuse.Model.ModelEntity as ModelS
import Reuse.Common.View as ViewC
import Reuse.List.Message as MsgS

viewList : (model -> Html (MsgS.ListMsg model msg)) -> ModelS.ModelEntityList model -> Html (MsgS.ListMsg model msg)
viewList elementView listModel = 
   div [] [
     div[] [button [onClick <| MsgS.CreateRequest] [text "Create"]] ,
     div[] <| List.map (viewListElement elementView) listModel.elements ,
     viewError listModel 
   ] 
  
viewListElement : (model -> Html (MsgS.ListMsg model msg)) -> ModelS.ModelEntity model -> Html (MsgS.ListMsg model msg)
viewListElement elementView element =
   div [] [
     div [] [elementView element.entity] , 
     div [] [button [onClick <| MsgS.ViewRequest element.id] [text "View"]]
    ] 
    
-- TODO generalize (this is same as in common)
viewError : ModelS.ModelEntityList model -> Html msg
viewError model =
    case model.err of
       Just (txt, _) -> 
          ViewC.viewErrorTxt txt
       Nothing -> 
          div [] []
