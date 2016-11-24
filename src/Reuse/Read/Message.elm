module Reuse.Read.Message exposing (..)

import Platform.Cmd as Cmd
import Reuse.Http as HttpS
import Reuse.Model.ModelPlus as ModelS


type ReadMsg model msg = 
    Init Int
    | EditRequest
    | DeleteRequest
    | CancelRequest
    | GetHttpResult (HttpS.HttpRes HttpS.HttpGET model)
    | DeleteHttpResult (HttpS.HttpRes HttpS.HttpDELETE ())

debug : String -> a -> a
debug = Debug.log 


-- model and msg are inner, eg. ThingMsg, Thing
type alias UpdateConfig model msg = {
    empty : model 
  , getModel : Int -> Cmd (HttpS.HttpRes HttpS.HttpGET model)
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
    debug "Model Id not set " (ModelS.setErr "No ID configured" Nothing model, Cmd.none)
  Just modelId -> case msg of
    Init modelId_ -> 
        debug "InitView " (ModelS.initExistingModel modelId_ updateConf.empty, 
                                 Cmd.map GetHttpResult <| updateConf.getModel modelId_)
    GetHttpResult getModelMsg -> case getModelMsg of 
         HttpS.HttpResOk HttpS.HttpGET newInnerModel ->
            debug "GetResOK " (ModelS.setModel newInnerModel model, Cmd.none)
         HttpS.HttpResErr HttpS.HttpGET msg error ->
            -- let _ = Debug.log "error" err
            debug ("GetResErr " ++ toString error) (ModelS.setErr msg (Just error) model, Cmd.none)
    DeleteHttpResult getModelMsg -> case getModelMsg of 
         HttpS.HttpResOk HttpS.HttpDELETE _ ->
            debug "DeleteResOk " (model, updateConf.exitCmd modelId)
         HttpS.HttpResErr HttpS.HttpDELETE msg error ->
            debug ("DeleteResErr " ++ toString error) (ModelS.setErr msg (Just error) model, Cmd.none)
    EditRequest -> 
            debug "EditRequest" (model, updateConf.editCommand modelId)
    DeleteRequest -> 
            debug "DeleteRequest " (model, Cmd.map DeleteHttpResult <| updateConf.deleteModel modelId)
    CancelRequest -> 
            debug "CancelReq" (model, updateConf.exitCmd modelId)
  
    
