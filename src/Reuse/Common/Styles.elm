module Reuse.Common.Styles exposing (..)

import Html 
import Html.Attributes as Attr
import Pure as Pure 

stdStyle : String
stdStyle = "std"

lBox : String
lBox = "l-box"

formDefault : List( Html.Attribute msg )
formDefault = [ Attr.classList [(Pure.form, True), (Pure.formAligned, True)]] 

formRowDefault : List( Html.Attribute msg )
formRowDefault = [Attr.class Pure.controlGroup]

formButtons : List( Html.Attribute msg )
formButtons = [Attr.class "pure-controls"]

textInputDefault : List( Html.Attribute msg )
textInputDefault = [Attr.class stdStyle]

textAreaDefault : List( Html.Attribute msg )
textAreaDefault = [Attr.class stdStyle]

buttonDefault : List( Html.Attribute msg )
buttonDefault = [Attr.classList [(lBox, True), (Pure.button, True)] ]

buttonPrimary : List( Html.Attribute msg )
buttonPrimary = [Attr.classList [(lBox, True), (Pure.button, True), (Pure.buttonPrimary, True)]] 

errorBox : List( Html.Attribute msg )
errorBox = [Attr.class "error"]
