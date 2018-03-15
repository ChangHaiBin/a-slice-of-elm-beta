module Decoder exposing (decodeGraph)

import Json.Decode exposing (Decoder, Value, bool, decodeValue, float, int, list, string)
import Json.Decode.Pipeline exposing (custom, decode, hardcoded, optional, required)
import Types exposing (..)


decodeGraph : Value -> Result String GraphData
decodeGraph json =
    decodeValue graphData json



{-
   TODO: replace the "hardcoded" entries in the decoding pipeline with actual decoders

   Check the browsers console log to see the Json being passed to Elm
-}


graphData : Decoder GraphData
graphData =
    decode GraphData
        |> hardcoded (GraphOptions True False False)
        |> required "value" graphValues
        |> hardcoded []
        |> required "edges" (list edge)


graphValues : Decoder GraphValues
graphValues =
    decode GraphValues
        |> required "nodesep" int
        |> required "ranksep" int
        |> required "rankdir" string
        |> required "marginx" int
        |> required "marginy" int
        |> required "width" int
        |> required "height" int


edge : Decoder Edge
edge =
    decode Edge
        |> required "v" string
        |> required "w" string
        |> required "value" edgeValue


edgeValue : Decoder EdgeValue
edgeValue =
    decode EdgeValue
        |> required "label" string
        |> required "height" int
        |> required "width" int
        |> required "x" float
        |> required "y" float
        |> required "points" (list point)


point : Decoder Point
point =
    decode Point
        |> required "x" float
        |> required "y" float
