module Reuse.Edit.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Reuse.Model.ModelPlus as ModelS
import Reuse.Edit.Message as MsgS 
import Reuse.Common.View as ViewC
import Reuse.Common.Styles as DefStyle

viewError : ModelS.ModelPlus model -> Html msg
viewError  =  ViewC.viewError

viewButtons : ModelS.ModelPlus model -> Html (MsgS.EditMsg model msg)
viewButtons model =    
     div DefStyle.formButtons [
          button (DefStyle.buttonPrimary ++ [onClick MsgS.SaveRequest]) [text "Save"],
          button (DefStyle.buttonDefault ++ [onClick MsgS.CancelRequest]) [text "Cancel"]
     ]
  
