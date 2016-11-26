module Reuse.Edit.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Reuse.Model.ModelPlus as ModelS
import Reuse.Edit.Message as MsgS 
import Reuse.Common.View as ViewC
import Reuse.Common.Styles as DefStyle

viewError : ModelS.ModelPlus model -> Html msg
viewError model =  div DefStyle.formMsg [ViewC.viewError model]

viewButtons : ModelS.ModelPlus model -> Html (MsgS.EditMsg model msg)
viewButtons model =    
     div DefStyle.formButtons [
          button (DefStyle.buttonPrimary ++ [onClick MsgS.SaveRequest]) [text "Save"],
          button (DefStyle.buttonDefault ++ [onClick MsgS.CancelRequest]) [text "Cancel"]
     ]

viewFormRow : (String, Html (MsgS.EditMsg model msg))  -> Html (MsgS.EditMsg model msg)
viewFormRow (label_, fieldHtml) =
   div DefStyle.formRowDefault [ label [] [text label_], fieldHtml  ]

--
-- expects Entity to provide a list of pairs: (labelName, fieldHtml)
--
viewReuse : (model -> List (String, Html (MsgS.EditMsg model msg))) -> ModelS.ModelPlus model -> Html (MsgS.EditMsg model msg)
viewReuse fieldSetElements model =
  Html.form DefStyle.formDefault [
     Html.fieldset [] (List.map viewFormRow (fieldSetElements model.model) ++
        [ viewError model, viewButtons model])
  ] 
