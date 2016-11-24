module App.Message exposing (..)

import Thing.Combined.Logic as ThingModule
import Routing.Logic as RoutingModule

type Msg = 
     ThingModuleMsg ThingModule.Msg
   | RoutingModuleMsg RoutingModule.Msg
