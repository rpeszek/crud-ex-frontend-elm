module Reuse.Model.ModelEntity exposing (..)

import Http 

type alias ModelEntity model = {
    id : Int
  , entity : model
}

type alias ModelEntityList model = {
    elements : List (ModelEntity model)
  , err :  Maybe (String, Maybe Http.Error)   
}

emptyModelEntityList : ModelEntityList model
emptyModelEntityList = {elements = [], err = Nothing}

setErr : String -> Maybe Http.Error -> ModelEntityList model -> ModelEntityList model
setErr msg err model = {model | err = Just (msg, err)}

setElements : List (ModelEntity model) -> ModelEntityList model -> ModelEntityList model
setElements newEls model = {model | elements = newEls}
