import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }



-- MODEL


type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  }


model : Model
model =
  Model "" "" ""



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Password password ->
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ viewInput [ type_ "text", placeholder "Name", onInput Name ]
    , viewInput [ type_ "password", placeholder "Password", onInput Password ]
    , viewInput [ type_ "password", placeholder "Re-enter Password", onInput PasswordAgain ]
    , viewValidation model
    ]

viewInput : List (Html.Attribute Msg) -> Html Msg
viewInput inputattribs = 
    div []
    [ span [] [ text "asdas" ]
    , input inputattribs []
     ]

-- viewInput :String -> List (Html.Attribute Msg) -> Html Msg
-- viewInput labeltext inputattribs = 
--     div []
--     [ span [] [ text labeltext  ]
--     , input inputattribs []
--       ]


viewValidation : Model -> Html msg
viewValidation model =
  let
    (color, message) =
      if String.length model.password < 8 then
        ("red", "Passwords are lame")
      else if model.password /= model.passwordAgain then
        ("red", "Passwords do not match!")
      else
        ("green", "OK")
  in
    div [ style [("color", color)] ] [ text message ]
