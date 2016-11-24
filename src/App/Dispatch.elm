module App.Dispatch exposing (..)

import String
import App.Message as App
import Routing.ElmRoute exposing (..)
import UrlParser exposing (..)
import Thing.Combined.Logic as ThingModule
import Reuse.List.Message as List
import Reuse.Edit.Message as Edit
import Reuse.Read.Message as Read

dispatch : ElmRoute -> App.Msg
dispatch elmRoute = case elmRoute of
         ListThingsR -> 
              App.ThingModuleMsg <| ThingModule.List <| List.Init
         CreateThingR ->
              App.ThingModuleMsg <| ThingModule.Edit <| Edit.Init Nothing
         ViewThingR tid ->
              App.ThingModuleMsg <| ThingModule.Read <| Read.Init tid
         EditThingR tid ->
              App.ThingModuleMsg <| ThingModule.Edit <| Edit.Init <| Just tid
