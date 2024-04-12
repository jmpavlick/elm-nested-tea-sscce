module Main exposing (..)

import Browser
import Html
import Html.Events
import Signup


main : Program () Model Msg
main =
    Browser.element
        { init = always init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }


init : ( Model, Cmd Msg )
init =
    ( { counter = 0, signupModel = Signup.init }
    , Cmd.none
    )


type alias Model =
    { counter : Int
    , signupModel : Signup.Model
    }


type Msg
    = UserClickedIncrement
    | UserClickedDecrement
    | GotSignupMsg Signup.Msg


view : Model -> Html.Html Msg
view model =
    Html.div []
        [ Html.button [ Html.Events.onClick UserClickedIncrement ] [ Html.text "Increment" ]
        , Html.div [] [ Html.text <| String.fromInt model.counter ]
        , Html.button [ Html.Events.onClick UserClickedDecrement ] [ Html.text "Decrement" ]
        , Html.hr [] []
        , Signup.view model.signupModel |> Html.map GotSignupMsg
        ]



--


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UserClickedIncrement ->
            ( { model | counter = model.counter + 1 }, Cmd.none )

        UserClickedDecrement ->
            ( { model | counter = model.counter - 1 }, Cmd.none )

        GotSignupMsg signupMsg ->
            let
                ( signupModel, signupCmd ) =
                    Signup.update signupMsg model.signupModel
            in
            ( { model | signupModel = signupModel }
            , Cmd.map GotSignupMsg signupCmd
            )
