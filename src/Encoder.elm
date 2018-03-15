module Encoder exposing (graphToJsonStr)

-- import GraphParser
-- import Parser exposing (Error)
-- import Types exposing (..)
{-
     Json that needs to be passed to the dagre.js
     TODO: Add the encoding of GraphData

   {
     "nodes": [
       {
         "v": "kspacey",
         "value": {
           "label": "Kevin Spacey",
           "width": 140,
           "height": 50
         }
       },
       ...
     ],
     "edges": [
       {
         "v": "kspacey",
         "w": "swilliams",
         "value": {
           "label": "worked with",
           "width": 90,
           "height": 10
         }
       },
       ...
     ],
     "options": {
       "directed": true,
       "multigraph": false,
       "compound": false
     },
     "value": {
       "nodesep": 10,
       "ranksep": 100,
       "rankdir": "LR",
       "marginx": 20,
       "marginy": 20
     }

   }

-}


graphToJsonStr : String -> String
graphToJsonStr str =
    "{\"TODO\": \"Add the Json encoding of the graph data\"}"
