module Reuse.Read.Message exposing (..)

import Platform.Cmd as Cmd
import Util.Http as HttpS
import Reuse.Model.ModelPlus as ModelS


type ReadMsg model msg = 
    InitMsg Int
    | EditRequest
    | DeleteRequest
    | CancelRequest
    | GetHttpResult (HttpS.HttpRes HttpS.HttpGET (Maybe model))
    | DeleteHttpResult (HttpS.HttpRes HttpS.HttpDELETE ())


-- model and msg are inner, eg. ThingMsg, Thing
type alias UpdateConfig model msg = {
    empty : model 
  , getModel : Int -> Cmd (HttpS.HttpRes HttpS.HttpGET (Maybe model))
  , deleteModel : Int -> Cmd (HttpS.HttpRes HttpS.HttpDELETE ())
  , editCommand : Int -> Cmd (ReadMsg model msg)
  , exitCmd : Int -> Cmd (ReadMsg model msg)  -- used on delete only
}

updateReadModel : UpdateConfig model msg -> 
                  ReadMsg model msg -> 
                  ModelS.ModelPlus model -> 
                  (ModelS.ModelPlus model, Cmd (ReadMsg model msg))

updateReadModel updateConf msg model = case model.id of 
  Nothing ->
    -- on view page modelId should always be set for testing initialize to -1
    Debug.log "Model Id not set " (ModelS.setErr "No ID configured" Nothing model, Cmd.none)
  Just modelId -> case msg of
    InitMsg modelId_ -> 
        (ModelS.initExistingModel modelId_ updateConf.empty, 
                                 Cmd.map GetHttpResult <| updateConf.getModel modelId_)
    GetHttpResult getModelMsg -> case getModelMsg of 
         HttpS.HttpResOk HttpS.HttpGET (Just newInnerModel) ->
            (ModelS.setModel newInnerModel model, Cmd.none)
         HttpS.HttpResOk HttpS.HttpGET Nothing ->
            (ModelS.setErr "Invalid id" Nothing model, Cmd.none)
         HttpS.HttpResErr HttpS.HttpGET msg error ->
            -- let _ = Debug.log "error" err
            (ModelS.setErr msg (Just error) model, Cmd.none)
    DeleteHttpResult getModelMsg -> case getModelMsg of 
         HttpS.HttpResOk HttpS.HttpDELETE _ ->
            (model, updateConf.exitCmd modelId)
         HttpS.HttpResErr HttpS.HttpDELETE msg error ->
            (ModelS.setErr msg (Just error) model, Cmd.none)
    EditRequest -> 
            (model, updateConf.editCommand modelId)
    DeleteRequest -> 
            (model, Cmd.map DeleteHttpResult <| updateConf.deleteModel modelId)
    CancelRequest -> 
            (model, updateConf.exitCmd modelId)
  
    
