module App.Dispatch exposing (..)

import String
import App.Message as App
import ElmRoutes exposing (..)
import UrlParser exposing (..)
import Thing.Combined.Logic as ThingModule
import Reuse.List.Message as List
import Reuse.Edit.Message as Edit
import Reuse.Read.Message as Read

dispatch : ElmRoute -> App.Msg
dispatch elmRoute = case elmRoute of
         ListThingsR -> 
              App.ThingModuleMsg <| ThingModule.ListMsg <| List.InitMsg
         CreateThingR ->
              App.ThingModuleMsg <| ThingModule.EditMsg <| Edit.InitMsg Nothing
         ViewThingR tid ->
              App.ThingModuleMsg <| ThingModule.ReadMsg <| Read.InitMsg tid
         EditThingR tid ->
              App.ThingModuleMsg <| ThingModule.EditMsg <| Edit.InitMsg <| Just tid
