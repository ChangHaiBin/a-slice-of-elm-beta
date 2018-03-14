module View exposing (view)

import Bootstrap.Form as Form
import Bootstrap.Form.Textarea as Textarea
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Row as Row
import GraphParser
import Html
import Html.Attributes as HA
import Types exposing (..)


defaultGraphOptions : GraphOptions
defaultGraphOptions =
    GraphOptions True False False


defaultGraphValues : GraphValues
defaultGraphValues =
    GraphValues 10 100 "LR" 20 20 600 600


view : Model -> Html.Html Msg
view { editor, graph } =
    let
        errors =
            graphErrors editor

        hasErrors =
            List.any (\s -> s /= "") errors
    in
    Grid.containerFluid []
        [ Grid.row []
            [ Grid.col []
                [ Html.h1 []
                    [ Html.text "A slice of Elm "
                    , Html.small [ HA.attribute "class" "text-muted" ] [ Html.em [] [ Html.text "Beta" ] ]
                    ]
                , Html.p []
                    [ Html.text "Specify a graph in the left pane, and see the result in the right. The layout is calculated with the external JS library"
                    , Html.a [ HA.href "https://github.com/dagrejs/dagre/wiki" ] [ Html.text " dagre.js." ]
                    ]
                ]
            ]
        , Grid.row []
            [ Grid.col [] [ dataPane editor hasErrors ]
            , if hasErrors then
                Grid.col [] [ errorPane errors ]
              else
                Grid.col [] [ graphPane graph ]
            ]
        ]


dataPane : String -> Bool -> Html.Html Msg
dataPane editor hasErrors =
    Form.form []
        [ Form.group []
            [ Form.label [] [ Html.text "Graph specification:" ]
            , Textarea.textarea
                ([ Textarea.id "data"
                 , Textarea.rows 20
                 , Textarea.onInput Edit
                 , Textarea.value editor
                 ]
                    ++ (if hasErrors then
                            [ Textarea.danger ]
                        else
                            []
                       )
                )
            ]
        ]


errorPane : List String -> Html.Html Msg
errorPane errors =
    Form.form []
        [ Form.group []
            [ Form.label [] [ Html.text "Parse errors:" ]
            , Textarea.textarea
                [ Textarea.id "data"
                , Textarea.rows 20
                , Textarea.disabled
                , Textarea.attrs
                    [ HA.style
                        [ ( "overflow-x", "scroll" )
                        ]
                    ]
                , Textarea.value (String.join "\n" errors)
                ]
            ]
        ]


graphPane : Maybe GraphData -> Html.Html msg
graphPane graph =
    let
        numNodes =
            graph
                |> Maybe.map (List.length << .nodes)
                |> Maybe.withDefault 0

        numEdges =
            graph
                |> Maybe.map (List.length << .edges)
                |> Maybe.withDefault 0
    in
    Grid.container []
        [ Grid.row [ Row.attrs [ HA.attribute "class" "py-3" ] ]
            [ Grid.col []
                [ Html.text <| ("Graph has " ++ toString numNodes ++ " number nodes and " ++ toString numEdges ++ " edges")
                ]
            ]
        ]


graphErrors : String -> List String
graphErrors str =
    let
        parsed =
            GraphParser.parse str

        getError x =
            case x of
                Ok _ ->
                    ""

                Err err ->
                    err.source
                        ++ " : "
                        ++ toString err.problem
    in
    List.map getError parsed
