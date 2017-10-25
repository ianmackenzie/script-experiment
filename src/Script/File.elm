module Script.File
    exposing
        ( Error
        , File
        , name
        , read
        , write
        , writeTo
        )

import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode
import Script.Internal as Internal
import Script.Path as Path
import Script.Permissions exposing (Read, Write)


type alias File p =
    Internal.File p


type alias Error =
    { code : String
    , message : String
    }


errorDecoder : Decoder Error
errorDecoder =
    Decode.map2 Error
        (Decode.field "code" Decode.string)
        (Decode.field "message" Decode.string)


name : File p -> String
name (Internal.File path) =
    Path.name path


read : File (Read p) -> Internal.Script Error String
read (Internal.File path) =
    Internal.Invoke "readFile"
        (Path.encode path)
        (Decode.oneOf
            [ Decode.string |> Decode.map Internal.Succeed
            , errorDecoder |> Decode.map Internal.Fail
            ]
        )


write : String -> File (Write p) -> Internal.Script Error ()
write contents (Internal.File path) =
    Internal.Invoke "writeFile"
        (Encode.object
            [ ( "contents", Encode.string contents )
            , ( "path", Path.encode path )
            ]
        )
        (Decode.oneOf
            [ Decode.null (Internal.Succeed ())
            , errorDecoder |> Decode.map Internal.Fail
            ]
        )


writeTo : File (Write p) -> String -> Internal.Script Error ()
writeTo =
    flip write