module Reuse.List.Message exposing (..)

import Platform.Cmd as Cmd
import Reuse.Http as HttpS
import Reuse.Model.ModelEntity as ModelS


type ListMsg model msg = 
    InitMsg
    | ViewRequest Int
    | CreateRequest
    | GetHttpResult (HttpS.HttpRes HttpS.HttpGET (List (ModelS.ModelEntity model)))


-- model and msg are inner, eg. ThingMsg, Thing
type alias UpdateConfig model msg = {
    getModels : Cmd (HttpS.HttpRes HttpS.HttpGET (List (ModelS.ModelEntity model)))
  , viewCommand : Int -> Cmd (ListMsg model msg)
  , createCommand : Cmd (ListMsg model msg)
}

updateListModel : UpdateConfig model msg -> 
                  ListMsg model msg -> 
                  ModelS.ModelEntityList model -> 
                  (ModelS.ModelEntityList model, Cmd (ListMsg model msg))

updateListModel updateConf msg model = case msg of
    InitMsg -> 
        (ModelS.emptyModelEntityList, Cmd.map GetHttpResult <| updateConf.getModels)
    GetHttpResult getModelsMsg -> case getModelsMsg of 
         HttpS.HttpResOk HttpS.HttpGET newElements ->
            (ModelS.setElements newElements model, Cmd.none)
         HttpS.HttpResErr HttpS.HttpGET msg error ->
            -- let _ = Debug.log "error" err
            (ModelS.setErr msg (Just error) model, Cmd.none)
    ViewRequest modelId -> 
            (model, updateConf.viewCommand modelId)
    CreateRequest  -> 
            (model, updateConf.createCommand)
  
    
