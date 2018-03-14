module GraphParserTest exposing (..)

-- import Fuzz exposing (Fuzzer, int, list, string)

import Expect exposing (Expectation)
import GraphParser exposing (parse)
import Test exposing (..)
import Types exposing (..)


suite : Test
suite =
    describe "The Graph Parser"
        [ test "parse simple node" <|
            \_ ->
                Expect.equal (parse "A: Kevin")
                    [ Ok (N "A" "Kevin") ]
        ]
