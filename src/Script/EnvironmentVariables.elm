module Script.EnvironmentVariables exposing (EnvironmentVariables, get)

import Dict
import Script.Internal as Internal


type alias EnvironmentVariables =
    Internal.EnvironmentVariables


get : String -> EnvironmentVariables -> Maybe String
get name (Internal.EnvironmentVariables platform dict) =
    case platform of
        Internal.Windows ->
            Dict.get (String.toUpper name) dict

        Internal.Posix ->
            Dict.get name dict
