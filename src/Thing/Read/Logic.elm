module Thing.Read.Logic exposing (..)

import Thing.Model exposing (Thing, emptyThing)
import Thing.Http as ThingHttp
import Reuse.Http as HttpS
import Reuse.Model.ModelPlus as ModelS
import Reuse.Read.Message as MsgS 


type alias Msg = MsgS.ReadMsg Thing ()
type alias Model = ModelS.ModelPlus Thing

-- model in init is not important 
-- it is replaced when Init message is processed
initModel : Model
initModel = {id = Just -1, model = emptyThing, err = Nothing}

config : (Int -> Cmd Msg) -> (Int -> Cmd Msg) -> MsgS.UpdateConfig Thing ()
config editCmd exitCmd = {
       empty = emptyThing
     , getModel = ThingHttp.getThing
     , deleteModel = ThingHttp.deleteThing
     , editCommand = editCmd
     , exitCmd = exitCmd }

update :   (Int -> Cmd Msg) ->
           (Int -> Cmd Msg) ->
           Msg -> 
           Model -> 
           (Model, Cmd Msg)

update editCmd exitCmd = MsgS.updateReadModel (config editCmd exitCmd)
