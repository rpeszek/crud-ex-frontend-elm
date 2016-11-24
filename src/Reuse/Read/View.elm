module Reuse.Read.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Reuse.Model.ModelPlus as ModelS
import Reuse.Read.Message as MsgS 
import Reuse.Common.View as ViewC

viewError : ModelS.ModelPlus model -> Html msg
viewError  =  ViewC.viewError

viewButtons : ModelS.ModelPlus model -> Html (MsgS.ReadMsg model msg)
viewButtons model =    
    div [] [
     div [] [button [onClick MsgS.EditRequest] [text "Edit"]],
     div [] [button [onClick MsgS.DeleteRequest] [text "Delete"]],
     div [] [button [onClick MsgS.CancelRequest] [text "Cancel"]]
    ]
