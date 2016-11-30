module ServerRoutes exposing (..)

import Thing.Model exposing (ThingId)
import StaticConfig exposing (serverBase)

-- serverBase = "http://localhost:3000"

thingsR : String
thingsR = serverBase ++ "/things"

thingR : ThingId -> String
thingR tId = serverBase ++ "/things/" ++ toString tId
