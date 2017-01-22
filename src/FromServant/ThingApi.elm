module FromServant.ThingApi exposing (..)

import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
import Json.Encode
import Http
import String


type alias Thing =
    { name : String
    , description : String
    , userId : Maybe (Int)
    }

type alias ThingEntity =
    { id : Int
    , entity :Thing
    }

decodeThing : Decoder Thing
decodeThing =
    decode Thing
        |> required "name" string
        |> required "description" string
        |> required "userId" (maybe int)

encodeThing : Thing -> Json.Encode.Value
encodeThing x =
    Json.Encode.object
        [ ( "name", Json.Encode.string x.name )
        , ( "description", Json.Encode.string x.description )
        , ( "userId", (Maybe.withDefault Json.Encode.null << Maybe.map Json.Encode.int) x.userId )
        ]

decodeThingEntity : Decoder ThingEntity
decodeThingEntity =
    decode ThingEntity
        |> required "id" int
        |> required "entity" decodeThing

getThings : String -> Http.Request (List (ThingEntity))
getThings urlBase =
    Http.request
        { method =
            "GET"
        , headers =
            []
        , url =
            String.join "/"
                [ urlBase
                , "things"
                ]
        , body =
            Http.emptyBody
        , expect =
            Http.expectJson (list decodeThingEntity)
        , timeout =
            Nothing
        , withCredentials =
            False
        }

postThings : String -> Thing -> Http.Request (ThingEntity)
postThings urlBase body =
    Http.request
        { method =
            "POST"
        , headers =
            []
        , url =
            String.join "/"
                [ urlBase
                , "things"
                ]
        , body =
            Http.jsonBody (encodeThing body)
        , expect =
            Http.expectJson decodeThingEntity
        , timeout =
            Nothing
        , withCredentials =
            False
        }

getThingsByThingId : String -> Int -> Http.Request (Maybe (Thing))
getThingsByThingId urlBase thingId =
    Http.request
        { method =
            "GET"
        , headers =
            []
        , url =
            String.join "/"
                [ urlBase
                , "things"
                , thingId |> toString |> Http.encodeUri
                ]
        , body =
            Http.emptyBody
        , expect =
            Http.expectJson (maybe decodeThing)
        , timeout =
            Nothing
        , withCredentials =
            False
        }

putThingsByThingId : String -> Int -> Thing -> Http.Request (Thing)
putThingsByThingId urlBase thingId body =
    Http.request
        { method =
            "PUT"
        , headers =
            []
        , url =
            String.join "/"
                [ urlBase
                , "things"
                , thingId |> toString |> Http.encodeUri
                ]
        , body =
            Http.jsonBody (encodeThing body)
        , expect =
            Http.expectJson decodeThing
        , timeout =
            Nothing
        , withCredentials =
            False
        }

deleteThingsByThingId : String -> Int -> Http.Request (())
deleteThingsByThingId urlBase thingId =
    Http.request
        { method =
            "DELETE"
        , headers =
            []
        , url =
            String.join "/"
                [ urlBase
                , "things"
                , thingId |> toString |> Http.encodeUri
                ]
        , body =
            Http.emptyBody
        , expect =
            Http.expectStringResponse
                (\{ body } ->
                    Ok ()
-- Currently there Servant generates empty list on empty response
--                    if String.isEmpty body then
--                        Ok ()
--                    else
--                        Err "Expected the response body to be empty"
                )
        , timeout =
            Nothing
        , withCredentials =
            False
        }
