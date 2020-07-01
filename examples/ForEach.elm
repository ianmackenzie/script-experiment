module ForEach exposing (main)

import Script exposing (Script)


script : Script.Init -> Script String ()
script { arguments } =
    case arguments of
        [] ->
            Script.fail "Please provide a list numbers separated by spaces"

        _ ->
            arguments
                |> Script.each
                    (\argument ->
                        Script.printLine <|
                            case String.toFloat argument of
                                Just value ->
                                    let
                                        squared =
                                            value * value
                                    in
                                    argument
                                        ++ " squared is "
                                        ++ String.fromFloat squared

                                Nothing ->
                                    argument ++ " is not a number!"
                    )


main : Script.Program
main =
    Script.program script
