module Reuse.Read.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Reuse.Model.ModelPlus as ModelS
import Reuse.Read.Message as MsgS 
import Reuse.Common.View as ViewC
import Reuse.Common.Styles as DefStyle
 
viewError : ModelS.ModelPlus model -> Html msg
viewError  =  ViewC.viewError

viewButtons : ModelS.ModelPlus model -> Html (MsgS.ReadMsg model msg)
viewButtons model =    
    div DefStyle.buttonSet [
       button (DefStyle.buttonPrimary ++ [onClick MsgS.EditRequest]) [text "Edit"],
       button (DefStyle.buttonDefault ++ [onClick MsgS.DeleteRequest]) [text "Delete"],
       button (DefStyle.buttonDefault ++ [onClick MsgS.CancelRequest]) [text "Cancel"]
    ]

viewRow : (String, Html (MsgS.ReadMsg model msg)) -> List (Html (MsgS.ReadMsg model msg))
viewRow (label_, fieldHtml) = 
  [
   div DefStyle.readLabel
    [ text label_
    ],
   fieldHtml
  ] 

viewReuse : (model -> List (String, Html (MsgS.ReadMsg model msg))) -> ModelS.ModelPlus model -> Html (MsgS.ReadMsg model msg)
viewReuse fieldList model =
  div DefStyle.readGrid <| (List.concat <| List.map viewRow <| fieldList model.model) ++ [viewError model, viewButtons model]
