{-
 Http interface for 'Thing' based on code generated by Servant
-}
module Thing.Http exposing (..)

import FromServant.ThingApi as ServantGenerated 
import Http
import Util.Http as HttpS

import StaticConfig exposing (serverBase)

import ServerRoutes exposing (..) -- TODO document no longer used with Servant
import Thing.Model as Model

getThing : Model.ThingId -> Cmd (HttpS.HttpRes HttpS.HttpGET (Maybe Model.Thing))
getThing tId =
  let
    errMsg = "Error Retrieving Thing " ++ toString tId
    request = ServantGenerated.getThingsByThingId serverBase tId 
  in
    Http.send (HttpS.resultConverter HttpS.HttpGET errMsg) request

getThings :  Cmd (HttpS.HttpRes HttpS.HttpGET (List Model.ThingEntity))
getThings  =
  let
    errMsg = "Error Retrieving Things " 
    request = ServantGenerated.getThings serverBase
  in
    Http.send (HttpS.resultConverter HttpS.HttpGET errMsg) request

putThing : Model.ThingId -> Model.Thing -> Cmd (HttpS.HttpRes HttpS.HttpPUT Model.Thing)
putThing tId thing =
  let
    errMsg = "Error Saving Thing " ++ toString tId ++ ": " ++ toString thing
    request = ServantGenerated.putThingsByThingId serverBase tId thing
  in
    Http.send (HttpS.resultConverter HttpS.HttpPUT errMsg) request

postThing : Model.Thing -> Cmd (HttpS.HttpRes HttpS.HttpPOST Model.ThingEntity)
postThing thing =
  let
    errMsg = "Error Creating Thing " ++ toString thing
    request = ServantGenerated.postThings serverBase thing
  in
    Http.send (HttpS.resultConverter HttpS.HttpPOST errMsg) request

deleteThing : Model.ThingId -> Cmd (HttpS.HttpRes HttpS.HttpDELETE ())
deleteThing tId = 
  let
    errMsg = "Error Deleting Thing " ++ toString tId
    request = ServantGenerated.deleteThingsByThingId serverBase tId
  in
    Http.send (HttpS.resultConverter HttpS.HttpDELETE errMsg) request
