module Signup exposing (Model, Msg, init, update, view)

import Html
import Html.Attributes
import Html.Events


type Model
    = Model
        { nameField : String
        }


type Msg
    = UserTypedInField String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg (Model model) =
    case msg of
        UserTypedInField value ->
            ( Model { model | nameField = value }
            , Cmd.none
            )


view : Model -> Html.Html Msg
view (Model model) =
    Html.div []
        [ Html.input
            [ Html.Attributes.value model.nameField
            , Html.Events.onInput UserTypedInField
            ]
            []
        ]


init : Model
init =
    Model { nameField = "" }
