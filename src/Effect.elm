module Effect exposing (..)

import Random


type Effect msg
    = Batch (List (Effect msg))
    | None
    | GenerateRandomNumber Int Int (Int -> msg)


none : Effect msg
none =
    None


batch : List (Effect msg) -> Effect msg
batch effects =
    Batch effects


effectToCmd : Effect msg -> Cmd msg
effectToCmd effect =
    case effect of
        Batch effects ->
            Cmd.batch <| List.map effectToCmd effects

        None ->
            Cmd.none

        GenerateRandomNumber lo hi toMsg ->
            Random.generate toMsg <| Random.int lo hi


map : (a -> msg) -> Effect a -> Effect msg
map inMsg effect =
    case effect of
        Batch effects ->
            Batch (List.map (map inMsg) effects)

        None ->
            None

        GenerateRandomNumber lo hi toMsg ->
            GenerateRandomNumber lo hi (toMsg >> inMsg)
