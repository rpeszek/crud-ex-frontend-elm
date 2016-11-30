module Thing.Http exposing (..)

import Http
import Task
import Json.Decode as Json
import Util.Http as HttpS
import ServerRoutes exposing (..)
import Thing.Model as Model


getThing : Model.ThingId -> Cmd (HttpS.HttpRes HttpS.HttpGET Model.Thing)
getThing tId =
  let
    errMsg = "Error Retrieving Thing " ++ toString tId
    request =
      Http.get Model.thingJsonDecoder (thingR tId) 
  in
    Task.perform (HttpS.HttpResErr HttpS.HttpGET errMsg) (HttpS.HttpResOk HttpS.HttpGET) request

getThings :  Cmd (HttpS.HttpRes HttpS.HttpGET (List Model.ThingEntity))
getThings  =
  let
    errMsg = "Error Retrieving Things " 
    request =
      Http.get (Json.list Model.thingEntityJsonDecoder) thingsR 
  in
    Task.perform (HttpS.HttpResErr HttpS.HttpGET errMsg) (HttpS.HttpResOk HttpS.HttpGET) request

putThing : Model.ThingId -> Model.Thing -> Cmd (HttpS.HttpRes HttpS.HttpPUT Model.Thing)
putThing tId thing =
  let
    errMsg = "Error Saving Thing " ++ toString tId ++ ": " ++ toString thing
    request =
      HttpS.put Model.thingJsonDecoder (thingR tId) (Model.thingJsonEncoder thing)
  in
    Task.perform (HttpS.HttpResErr HttpS.HttpPUT errMsg) (HttpS.HttpResOk HttpS.HttpPUT) request

postThing : Model.Thing -> Cmd (HttpS.HttpRes HttpS.HttpPOST Model.ThingEntity)
postThing thing =
  let
    errMsg = "Error Creating Thing " ++ toString thing
    request =
      HttpS.post Model.thingEntityJsonDecoder thingsR (Model.thingJsonEncoder thing)
  in
    Task.perform (HttpS.HttpResErr HttpS.HttpPOST errMsg) (HttpS.HttpResOk HttpS.HttpPOST) request

deleteThing : Model.ThingId -> Cmd (HttpS.HttpRes HttpS.HttpDELETE ())
deleteThing tId = 
  let
    errMsg = "Error Deleting Thing " ++ toString tId
    request =
      HttpS.delete (thingR tId)
  in
    Task.perform (HttpS.HttpResErr HttpS.HttpDELETE errMsg) (HttpS.HttpResOk HttpS.HttpDELETE) request
