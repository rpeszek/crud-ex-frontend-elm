module Reuse.Model.ModelPlus exposing (..)

import Http 

type alias ModelPlus model = {
   id    : Maybe Int
 , model : model
 , err :  Maybe (String, Maybe Http.Error)   
}


initNewModel : model -> ModelPlus model
initNewModel m = {id = Nothing, model = m, err = Nothing}

initExistingModel : Int -> model -> ModelPlus model
initExistingModel mId m = {id = Just mId, model = m, err = Nothing}
 
setErr : String -> Maybe Http.Error -> ModelPlus model -> ModelPlus model
setErr msg err model = {model | err = Just (msg, err)}

setModel : model -> ModelPlus model -> ModelPlus model
setModel inner model = {model | model = inner}
