module View exposing (view)

import GraphParser
import Html
import Html.Attributes as HA
import Svg exposing (..)
import Svg.Attributes as SA
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
    Html.div []
        [ Html.h1 []
            [ text "A slice of Elm "
            , Html.small [ HA.attribute "class" "text-muted" ] [ Html.em [] [ text "Beta" ] ]
            ]
        , Html.p []
            [ text "Specify a graph in the left pane, and see the result in the right. The layout is calculated with the external JS library"
            , Html.a [ HA.href "https://github.com/dagrejs/dagre/wiki" ] [ text " dagre.js." ]
            ]
        , Html.text "TODO: build the view code"
        , graphPane graph
        ]


graphPane : Maybe GraphData -> Html.Html msg
graphPane graph =
    let
        defaultGraph =
            GraphData defaultGraphOptions defaultGraphValues [] []

        graphData =
            Maybe.withDefault defaultGraph graph

        sw =
            toString graphData.values.width

        sh =
            toString graphData.values.height
    in
    svg
        [ SA.width sw, SA.height sh, SA.viewBox ("0 0 " ++ sw ++ " " ++ sh) ]
    <|
        viewNodes graphData.nodes
            ++ viewEdges graphData.edges


viewNodes : List Node -> List (Svg msg)
viewNodes nodes =
    List.map viewNode nodes


viewNode : Node -> Svg msg
viewNode node =
    let
        mx =
            toString <| node.value.x

        my =
            toString <| node.value.y

        sx =
            toString <| node.value.x - (toFloat node.value.width / 2.0)

        sy =
            toString <| node.value.y - (toFloat node.value.height / 2.0)

        sh =
            toString node.value.height

        sw =
            toString node.value.width
    in
    Svg.node "g"
        []
        [ rect
            [ SA.x sx
            , SA.y sy
            , SA.width sw
            , SA.height sh
            , SA.rx "10"
            , SA.ry "10"
            , SA.stroke "blue"
            , SA.fill "white"
            ]
            []
        , text_
            [ SA.x mx
            , SA.y my
            , SA.alignmentBaseline "central"
            , SA.textAnchor "middle"
            ]
            [ text node.value.label ]
        ]


viewEdges : List Edge -> List (Svg msg)
viewEdges edges =
    List.map viewEdge edges


viewEdge : Edge -> Svg msg
viewEdge edge =
    let
        mx =
            toString edge.values.x

        my =
            toString edge.values.y

        sx { x } =
            toString x

        sy { y } =
            toString y

        p2s p =
            sx p ++ "," ++ sy p

        pnts =
            String.join " " <| List.map p2s edge.values.points
    in
    node "g"
        []
        [ polyline [ SA.fill "none", SA.stroke "black", SA.points pnts ] []
        , text_
            [ SA.x mx
            , SA.y my
            , SA.alignmentBaseline "central"
            , SA.textAnchor "middle"
            ]
            [ text edge.values.label ]
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
