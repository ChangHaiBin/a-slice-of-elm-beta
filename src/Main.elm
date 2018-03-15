port module Main exposing (main)

import Decoder exposing (decodeGraph)
import Encoder exposing (graphToJsonStr)
import Html
import Json.Encode exposing (Value)
import Process
import Task
import TestGraph
import Time
import Types exposing (..)
import View exposing (view)


-- Init


init : ( Model, Cmd msg )
init =
    let
        model =
            Model Nothing TestGraph.data 0
    in
    ( model, layout (graphToJsonStr model.editor) )



-- Update


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        Edit str ->
            ( { model | editor = str, layoutRequested = model.layoutRequested + 1 }
            , Task.perform
                (\_ -> Layout)
                (Process.sleep (1 * Time.second))
            )

        Layout ->
            let
                outstanding =
                    if model.layoutRequested > 0 then
                        model.layoutRequested - 1
                    else
                        0
            in
            ( { model | layoutRequested = model.layoutRequested - 1 }
            , if outstanding > 0 then
                Cmd.none
              else
                layout (graphToJsonStr model.editor)
            )



-- Ports


port layout : String -> Cmd msg



{-
   TODO: add port and message handling to receive graph data from JS
   and turn it into GraphData value by calling decodeGraph
-}
-- Main


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
