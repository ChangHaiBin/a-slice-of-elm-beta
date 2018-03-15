module Decoder exposing (decodeGraph)

import Json.Decode exposing (Value)
import Types exposing (..)


{-
   TODO: Decode the incoming Json graph data into a GraphData value
   Look in the browsers console log to see the format of the provided Json
-}


decodeGraph : Value -> Result String GraphData
decodeGraph json =
    Ok <|
        GraphData
            (GraphOptions True False False)
            (GraphValues 10 100 "LR" 20 20 600 600)
            []
            []
