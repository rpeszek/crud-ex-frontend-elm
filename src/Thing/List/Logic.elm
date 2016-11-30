module Thing.List.Logic exposing (..)

import Thing.Model exposing (Thing, emptyThing)
import Thing.Http as ThingHttp
import Util.Http as HttpS
import Reuse.Model.ModelEntity as ModelS
import Reuse.List.Message as MsgS 


type alias Msg = MsgS.ListMsg Thing ()
type alias Model = ModelS.ModelEntityList Thing

initModel : Model
initModel = ModelS.emptyModelEntityList

config : (Int -> Cmd Msg) -> (() -> Cmd Msg) ->  MsgS.UpdateConfig Thing ()
config viewCmd createCmd = {
       getModels = ThingHttp.getThings
     , viewCommand = viewCmd 
     , createCommand = createCmd }

update :   (Int -> Cmd Msg) ->
           (() -> Cmd Msg) -> 
           Msg -> 
           Model -> 
           (Model, Cmd Msg)

update viewCmd createCmd = MsgS.updateListModel (config viewCmd createCmd)
