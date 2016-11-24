module Thing.Model exposing (..)

import Json.Decode exposing (Decoder, int, string, object2)
import Json.Decode.Pipeline exposing (decode, nullable, required)
import Json.Encode as Encode
import Reuse.Model.ModelPlus as ModelS

type alias ThingId = Int 

--TODO convert to ModelEntity Thing
type alias ThingEntity = {
    id : Int
  , entity : Thing
}

type alias Thing =
  { name : String
  , description : String
  , userId : Maybe Int
  }

emptyThing = {name = "", description = "", userId = Nothing}

thingJsonDecoder : Decoder Thing
thingJsonDecoder =
    decode Thing
      |> required "name" string
      |> required "description" string
      |> required "userId" (nullable int)

thingEntityJsonDecoder : Decoder ThingEntity
thingEntityJsonDecoder =
     decode ThingEntity
        |> required "id" int
        |> required "entity" thingJsonDecoder

thingJsonEncoder : Thing -> Encode.Value
thingJsonEncoder thing =
    let
        list =
            [ ( "name", Encode.string thing.name )
            , ( "description", Encode.string thing.description )
            ]
    in
        list
            |> Encode.object
