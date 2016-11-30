module Reuse.Edit.Message exposing (..)

import Platform.Cmd as Cmd
import Util.Http as HttpS
import Reuse.Model.ModelPlus as ModelS
import Reuse.Model.ModelEntity exposing (ModelEntity)

-- model and msg are inner, eg. ThingMsg, Thing
type EditMsg model msg = 
    InitMsg (Maybe Int)
    | InnerMsg msg
    | SaveRequest
    | CancelRequest
    | GetHttpResult (HttpS.HttpRes HttpS.HttpGET model)
    | PutHttpResult (HttpS.HttpRes HttpS.HttpPUT model)
    | PostHttpResult (HttpS.HttpRes HttpS.HttpPOST (ModelEntity model))

-- hmm that does compile (msg -> model -> cmd) could be data consturtor Cmd (EditMsg model msg)

-- model and msg are inner, eg. ThingMsg, Thing
type alias UpdateConfig model msg = {
    innerUpdate : msg -> model -> (model, Cmd (EditMsg model msg))
  , validate : model -> Result String model
  , empty : model
  , getModel : Int -> Cmd (HttpS.HttpRes HttpS.HttpGET model)
  , putModel : Int -> model -> Cmd (HttpS.HttpRes HttpS.HttpPUT model)
  , postModel : model -> Cmd (HttpS.HttpRes HttpS.HttpPOST (ModelEntity model))
  , exitCmd : Maybe Int -> Cmd (EditMsg model msg)
}

updateEditModel :  UpdateConfig model msg ->
                   EditMsg model msg -> 
                   ModelS.ModelPlus model -> 
                   (ModelS.ModelPlus model, Cmd (EditMsg model msg))

updateEditModel updateConf msg model = case msg of
    InitMsg initMaybeId -> case initMaybeId of
         Just modelId ->
              (ModelS.initExistingModel modelId updateConf.empty, 
                                 Cmd.map GetHttpResult <| updateConf.getModel modelId)
         Nothing ->
              (ModelS.initNewModel updateConf.empty, Cmd.none)
    GetHttpResult getModelMsg -> case getModelMsg of 
         HttpS.HttpResOk HttpS.HttpGET newInnerModel ->
            (ModelS.setModel newInnerModel model, Cmd.none)
         HttpS.HttpResErr HttpS.HttpGET msg error ->
            -- let _ = Debug.log "error" err
            (ModelS.setErr msg (Just error) model, Cmd.none)
    PutHttpResult getModelMsg -> case getModelMsg of 
         HttpS.HttpResOk HttpS.HttpPUT newInnerModel ->
            (ModelS.setModel newInnerModel model, updateConf.exitCmd model.id)
         HttpS.HttpResErr HttpS.HttpPUT msg error ->
            (ModelS.setErr msg (Just error) model, Cmd.none)
    PostHttpResult getModelMsg -> case getModelMsg of 
         HttpS.HttpResOk HttpS.HttpPOST newInnerModelEntity ->
            ({model | model = newInnerModelEntity.entity, id = Just newInnerModelEntity.id}, updateConf.exitCmd model.id)
         HttpS.HttpResErr HttpS.HttpPOST msg error ->
            (ModelS.setErr msg (Just error) model, Cmd.none)
    SaveRequest -> case updateConf.validate model.model of
         Ok validatedInnerModel ->
           case model.id of
             Just modelId -> 
                (ModelS.setModel validatedInnerModel model, Cmd.map PutHttpResult <| updateConf.putModel modelId validatedInnerModel)
             Nothing ->
                (ModelS.setModel validatedInnerModel model, Cmd.map PostHttpResult <| updateConf.postModel validatedInnerModel)
         Err errMsg ->
             Debug.log "validation err" (ModelS.setErr errMsg Nothing model, Cmd.none)
    CancelRequest -> 
            (model, updateConf.exitCmd model.id)
    InnerMsg innerMsg -> 
            let (newInnerModel, cmd) = updateConf.innerUpdate innerMsg model.model
            in (ModelS.setModel newInnerModel model, cmd)
    
