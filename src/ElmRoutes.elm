module ElmRoutes exposing (..)

import String
import Navigation as Nav
import UrlParser exposing (..)

type ElmRoute = ListThingsR | 
                CreateThingR |
                ViewThingR Int | 
                EditThingR Int 
              

defaultRoute : ElmRoute
defaultRoute = ListThingsR

toElmUrl : ElmRoute -> String
toElmUrl route = case route of 
      ListThingsR  -> "#"
      CreateThingR  -> "#thingscreate"
      ViewThingR tId -> "#thingsview/" ++ toString tId
      EditThingR tId -> "#thingsedit/" ++ toString tId

navigateTo : ElmRoute -> Cmd msg
navigateTo route = Nav.newUrl <| Debug.log "navigateTo" <| toElmUrl route


routeParser : Parser (ElmRoute -> a) a 
routeParser = oneOf
    [ map ListThingsR top
    , map CreateThingR (s "thingscreate")
    , map ViewThingR (s "thingsview" </> int)
    , map EditThingR (s "thingsedit" </> int)
    ]

parseElmRoute : Nav.Location -> Result String ElmRoute
parseElmRoute location = case parseHash routeParser location of
    Just route -> Ok route
    Nothing -> Err <| "Invalid route " ++ toString location
  
