module Main exposing (..)

import Browser
import Components exposing (primaryBtnCls, viewButton)
import Counter exposing (view)
import Effect exposing (Effect)
import Html exposing (div, h1, text)
import Html.Attributes exposing (class)
import Html.Events as Events


type Msg
    = MsgCounterB Counter.Msg
    | MsgCounterA Counter.Msg
    | MsgResetAll
    | MsgRandomizeAll


type alias Model =
    { counterA : Counter.Model
    , counterB : Counter.Model
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { counterA = 0, counterB = 0 }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MsgCounterA cmsg ->
            let
                ( counterA, aCmd ) =
                    Counter.update cmsg model.counterA
            in
            ( { model | counterA = counterA }, Effect.map MsgCounterA aCmd |> Effect.effectToCmd )

        MsgCounterB cmsg ->
            let
                ( counterB, bCmd ) =
                    Counter.update cmsg model.counterB
            in
            ( { model | counterB = counterB }, Effect.map MsgCounterB bCmd |> Effect.effectToCmd )

        MsgResetAll ->
            let
                ( counterA, aCmd ) =
                    Counter.update Counter.Reset model.counterA

                ( counterB, bCmd ) =
                    Counter.update Counter.Reset model.counterB
            in
            ( { model | counterA = counterA, counterB = counterB }
            , Effect.batch
                [ Effect.map MsgCounterA aCmd
                , Effect.map MsgCounterB bCmd
                ]
                |> Effect.effectToCmd
            )

        MsgRandomizeAll ->
            let
                ( counterA, aCmd ) =
                    Counter.update Counter.Randomize model.counterA

                ( counterB, bCmd ) =
                    Counter.update Counter.Randomize model.counterB
            in
            ( { model | counterA = counterA, counterB = counterB }
            , Effect.batch
                [ Effect.map MsgCounterA aCmd
                , Effect.map MsgCounterB bCmd
                ]
                |> Effect.effectToCmd
            )


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }


view : Model -> Html.Html Msg
view model =
    div [ class "min-h-100wh" ]
        [ div [ class "grid gap-4 px-4 py-4 justify-center" ]
            [ h1 [ class "text-neutral-700 text-2xl font-light text-center" ]
                [ text "ELM App Counter"
                ]
            , div [ class "flex gap-8" ]
                [ viewButton { text = "Reset all", event = Events.onClick MsgResetAll, class = primaryBtnCls }
                , viewButton { text = "Randomize all", event = Events.onClick MsgRandomizeAll, class = primaryBtnCls }
                ]
            , Html.map MsgCounterA (Counter.view model.counterA)
            , Html.map MsgCounterB (Counter.view model.counterB)
            ]
        ]
