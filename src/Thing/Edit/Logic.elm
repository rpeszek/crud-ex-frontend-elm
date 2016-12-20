module Thing.Edit.Logic exposing (..)

import Thing.Model exposing (Thing, emptyThing)
import Thing.Http as ThingHttp
import Util.Http as HttpS
import Reuse.Model.ModelPlus as ModelS
import Reuse.Edit.Message as MsgS 

type alias Msg = MsgS.EditMsg Thing ThingMsg
type alias Model = ModelS.ModelPlus Thing
 
type ThingMsg
    = NameChange String
    | DescriptionChange String

initModel : Model
initModel = ModelS.initNewModel emptyThing

config : (Maybe Int -> Cmd Msg) -> MsgS.UpdateConfig Thing ThingMsg 
config exitCmd = {  innerUpdate = updateThing,
                    validate = validateThing,
                    empty = emptyThing,
                    getModel = ThingHttp.getThing,
                    putModel = ThingHttp.putThing,
                    postModel = ThingHttp.postThing,
                    exitCmd = exitCmd }

validateThing : Thing -> Result String Thing
validateThing thing = Ok thing |> Result.andThen validateName |> Result.andThen validateDescription 

validateName : Thing -> Result String Thing
validateName thing = 
    if thing.name == "" then 
       Err "Please enter name"
    else 
       Ok thing

validateDescription : Thing -> Result String Thing
validateDescription thing = 
    if thing.description == "" then 
       Err "Please enter description"
    else 
       Ok thing


updateThing : ThingMsg -> Thing -> (Thing, Cmd Msg)
updateThing msg thing = case msg of
      NameChange name ->
        ({ thing | name = name }, Cmd.none)
      DescriptionChange description ->
        ({ thing | description = description }, Cmd.none)

update :   (Maybe Int -> Cmd Msg) -> 
           Msg -> 
           Model -> 
           (Model, Cmd Msg)

update exitCmd = MsgS.updateEditModel (config exitCmd)
