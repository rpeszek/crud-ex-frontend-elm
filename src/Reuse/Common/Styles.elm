module Reuse.Common.Styles exposing (..)

import Html 
import Html.Attributes as Attr
import Pure as Pure 

stdStyle : String
stdStyle = "std"

lBox : String
lBox = "l-box"
 
-- forms
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

-- read view
readGrid : List( Html.Attribute msg )
readGrid = [Attr.class Pure.grid ]

readLabel : List( Html.Attribute msg )
readLabel = [Attr.classList [("pure-u-3-24", True), ("bottom-padding-small", True)]]

readContent : List( Html.Attribute msg )
readContent = [Attr.classList [("pure-u-21-24", True), ("bottom-padding-small", True)]]

readLongContent : List( Html.Attribute msg )
readLongContent = [Attr.classList [("pure-u-21-24", True), ("long-text", True), ("bottom-padding-small", True)] ]

-- buttons
buttonSet : List( Html.Attribute msg )
buttonSet = [Attr.classList [("top-padding-medium", True)] ]

buttonDefault : List( Html.Attribute msg )
buttonDefault = [Attr.classList [(lBox, True), (Pure.button, True)] ]

buttonPrimary : List( Html.Attribute msg )
buttonPrimary = [Attr.classList [(lBox, True), (Pure.button, True), (Pure.buttonPrimary, True)]] 

-- list
listElement : List( Html.Attribute msg )
listElement = [Attr.classList [("bottom-padding-small", True)]]

listElementLink : List( Html.Attribute msg )
listElementLink = [Attr.classList [("left-marging-medium", True)]]

-- misc
errorBox : List( Html.Attribute msg )
errorBox = [Attr.class "error"]
