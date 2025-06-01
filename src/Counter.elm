module Counter exposing (..)

import Components exposing (primaryBtnCls, secondaryBtnCls, viewButton)
import Html
import Html.Attributes exposing (class)
import Html.Events as Events
import Random


type alias Model =
    Int


init : Model
init =
    0


type Msg
    = Increment
    | Decrement
    | Reset
    | Randomize
    | GotRandomNum Int


generateRandomInt : Int -> Int -> Cmd Msg
generateRandomInt a b =
    Random.generate GotRandomNum (Random.int a b)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( model + 1, Cmd.none )

        Decrement ->
            ( model - 1, Cmd.none )

        Reset ->
            ( 0, Cmd.none )

        Randomize ->
            ( model, generateRandomInt -Random.maxInt Random.maxInt )

        GotRandomNum n ->
            ( n, Cmd.none )


view : Model -> Html.Html Msg
view model =
    Html.div [ class "flex gap-8 items-center" ]
        [ viewButton { text = "-", event = Events.onClick Decrement, class = primaryBtnCls }
        , Html.span [ class "min-w-12 text-center bg-neutral-100 p-3 rounded-sm" ] [ Html.text (String.fromInt model) ]
        , viewButton { text = "+", event = Events.onClick Increment, class = primaryBtnCls }
        , viewButton { text = "Randomize", event = Events.onClick Randomize, class = secondaryBtnCls }
        , viewButton { text = "Reset", event = Events.onClick Reset, class = secondaryBtnCls }
        ]
