module Kintail.Script.Directory
    exposing
        ( Directory
        , file
        , name
        , subdirectory
        )

import Kintail.Script.File as File exposing (File)
import Kintail.Script.Internal as Internal
import Kintail.Script.Path as Path


type alias Directory p =
    Internal.Directory p


name : Directory p -> String
name (Internal.Directory path) =
    Path.name path


subdirectory : String -> Directory p -> Directory p
subdirectory relativePath (Internal.Directory path) =
    Internal.Directory (path ++ [ relativePath ])


file : String -> Directory p -> File p
file relativePath (Internal.Directory path) =
    Internal.File (path ++ [ relativePath ])