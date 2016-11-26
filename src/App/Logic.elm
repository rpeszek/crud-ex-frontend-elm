module App.Logic exposing (..)

import Navigation as Nav
import App.Message as App 
import App.Model as App
import App.Dispatch as Dispatch
import Thing.Combined.Logic as ThingModule
import Routing.Logic as RoutingModule
import Reuse.CmdExtras as CmdE
import Routing.ElmRoute as ElmRoute


thingConfig : ThingModule.UpdateConf
thingConfig = {
   editExitCmd = (\maybeTId -> case maybeTId of 
                     Just tId ->  ElmRoute.navigateTo <| ElmRoute.ViewThingR tId
                     Nothing -> ElmRoute.navigateTo ElmRoute.ListThingsR
                  )
 , readToEditCmd = (\tId -> ElmRoute.navigateTo <| ElmRoute.EditThingR tId)
 , readToExitCmd = (\_ -> ElmRoute.navigateTo ElmRoute.ListThingsR)
 , listToViewCmd = (\tId -> ElmRoute.navigateTo <| ElmRoute.ViewThingR tId )
 , listToCreateCmd = ElmRoute.navigateTo ElmRoute.CreateThingR }

update : App.Msg -> App.Model -> (App.Model, Cmd App.Msg)
update msg model = case Debug.log "App Msg" msg of
   App.RoutingModuleMsg innerMsg -> case innerMsg of
      RoutingModule.RouteMsg elmRoute ->
          (App.setRoute elmRoute model, CmdE.pure <| Debug.log "dispatchTo" <| Dispatch.dispatch elmRoute)
      RoutingModule.UnknownRouteMsg url -> 
          (App.setRouteErr url model, CmdE.pure <| Debug.log "dispatchErr" <| Dispatch.dispatch ElmRoute.defaultRoute )
   App.ThingModuleMsg innerMsg ->
          let (thingModel, thingCmd) = ThingModule.update thingConfig innerMsg model.thingM 
          in (App.setThingM thingModel model, Cmd.map App.ThingModuleMsg thingCmd)


-- deprecated (will not work after upgrade to next version)
type alias RouteData = Result String ElmRoute.ElmRoute

-- type alias Model = {
--    routeM : RoutingModule.Model
--  , thingM : ThingModule.Model } 


isRouteTheSame : RouteData -> App.Model -> Bool
isRouteTheSame data model = 
            let currentRoute = RoutingModule.getRoute model.routeM
            in case data of 
               Ok route ->
                  Debug.log "equals" (route == currentRoute)
               Err _ ->
                  Debug.log "e2" (currentRoute == ElmRoute.defaultRoute)  

routeParser : Nav.Parser (Result String ElmRoute.ElmRoute)
routeParser =
    Nav.makeParser ElmRoute.parseElmRoute


resolveParsedRoute : RouteData -> App.Msg
resolveParsedRoute res = case res of 
     Ok elmRoute -> 
          App.RoutingModuleMsg <| RoutingModule.RouteMsg elmRoute
     Err msg -> 
          App.RoutingModuleMsg <| RoutingModule.UnknownRouteMsg <| Debug.log "invalid route" msg
 
urlUpdate : RouteData -> App.Model -> (App.Model, Cmd App.Msg)
urlUpdate data model = 
       if isRouteTheSame data model 
       then (model, Cmd.none)
       else (model, CmdE.pure <| resolveParsedRoute data)

-- new version of library (after update to .18)
resolveLocation : Nav.Location -> App.Msg
resolveLocation location =
    let url = location.hash
        parsed = ElmRoute.parseElmRoute location
    in case parsed of 
       Ok elmRoute ->
          App.RoutingModuleMsg <| RoutingModule.RouteMsg elmRoute
       Err msg -> 
          App.RoutingModuleMsg <| RoutingModule.UnknownRouteMsg <| Debug.log msg url
