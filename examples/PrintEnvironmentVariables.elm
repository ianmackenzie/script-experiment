port module Main exposing (..)

import Json.Encode exposing (Value)
import Kintail.Script as Script exposing (Script, FileError)


printEnvironmentVariable : String -> Script x ()
printEnvironmentVariable name =
    Script.getEnvironmentVariable name
        |> Script.map (Maybe.withDefault "not defined")
        |> Script.andThen (\value -> Script.print (name ++ ": " ++ value))


script : List String -> Script Int ()
script filenames =
    filenames |> Script.forEach printEnvironmentVariable


port requestPort : Value -> Cmd msg


port responsePort : (Value -> msg) -> Sub msg


main =
    Script.run script requestPort responsePort