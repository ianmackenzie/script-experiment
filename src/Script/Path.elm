module Script.Path exposing (Path, encode, name)

import Json.Encode as Encode exposing (Value)
import Regex exposing (Regex)
import Script.Internal as Internal


type alias Path =
    Internal.Path


nameRegex : Regex
nameRegex =
    Regex.regex "([^\\\\/]+)[\\\\/]*$"


name : Path -> String
name path =
    case Regex.find (Regex.AtMost 1) nameRegex (String.join "/" path) of
        [ { match, submatches } ] ->
            case submatches of
                [ Just name ] ->
                    name

                _ ->
                    ""

        _ ->
            ""


encode : Path -> Value
encode path =
    Encode.list (List.map Encode.string path)