module Reuse.Edit.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Reuse.Model.ModelPlus as ModelS
import Reuse.Edit.Message as MsgS 
import Reuse.Common.View as ViewC

viewError : ModelS.ModelPlus model -> Html msg
viewError  =  ViewC.viewError

viewButtons : ModelS.ModelPlus model -> Html (MsgS.EditMsg model msg)
viewButtons model =    
    div [] [
     div [] [button [onClick MsgS.SaveRequest] [text "Save"]],
     div [] [button [onClick MsgS.CancelRequest] [text "Cancel"]]
    ]
