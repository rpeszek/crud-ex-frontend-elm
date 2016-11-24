module Thing.Combined.Logic exposing (..)

import Thing.Edit.Logic as Edit
import Thing.Read.Logic as Read
import Thing.List.Logic as List 

-- combo message (all messages used by Thing component)
type Msg = 
      Edit Edit.Msg 
    | Read Read.Msg 
    | List List.Msg  

type alias Model = {
   editM : Edit.Model
 , readM : Read.Model
 , listM : List.Model }

initModel : Model
initModel = {
   editM = Edit.initModel
 , readM = Read.initModel
 , listM = List.initModel }

-- TODO work in progress
type alias UpdateConf = {
   editExitCmd : (Maybe Int -> Cmd Edit.Msg)
 , readToEditCmd : (Int -> Cmd Read.Msg)
 , readToExitCmd : (Int -> Cmd Read.Msg)
 , listToViewCmd : (Int -> Cmd List.Msg)
 , listToCreateCmd : Cmd List.Msg
}

update : UpdateConf -> 
         Msg -> 
         Model -> 
         (Model, Cmd Msg)

update config msg model = case msg of
    Edit innerMsg -> 
        let (newInnerM, newCmd) = Edit.update config.editExitCmd innerMsg model.editM
        in ({model | editM = newInnerM}, Cmd.map Edit newCmd)
    Read innerMsg ->
        let (newInnerM, newCmd) = Read.update config.readToEditCmd config.readToExitCmd innerMsg model.readM
        in ({model | readM = newInnerM}, Cmd.map Read newCmd)
    List innerMsg ->
        let (newInnerM, newCmd) = List.update config.listToViewCmd config.listToCreateCmd innerMsg model.listM
        in ({model | listM = newInnerM}, Cmd.map List newCmd)
