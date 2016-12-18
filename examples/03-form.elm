import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Regex


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
  , age : String
  , hasBeenValidated : Bool
  }


model : Model
model =
  Model "" "" "" "" False



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String
    | Age String
    | Submit 


update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name, hasBeenValidated = False }

    Password password ->
      { model | password = password, hasBeenValidated = False }

    PasswordAgain password ->
      { model | passwordAgain = password, hasBeenValidated = False }

    Age age ->
      { model | age = age }
    
    Submit  ->
      { model | hasBeenValidated = True} 
    




-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ viewInput [ type_ "text", placeholder "Name", onInput Name ]
    , viewInput [ type_ "number", placeholder "Age", onInput Age ]
    , viewInput [ type_ "password", placeholder "Password", onInput Password ] 
    , viewInput [ type_ "password", placeholder "Re-enter Password", onInput PasswordAgain ]
    , isValidated model
    , button [onClick Submit ] [text "GO"]
    ]

viewInput : List (Html.Attribute Msg) -> Html Msg
viewInput inputthing = 
  div []
    [ span [] []
    , input inputthing [] 
    ]

isValidated : Model -> Html msg 
isValidated model =
  if not model.hasBeenValidated then
    div [] []
  else 
    viewValidation model
    


viewValidation : Model -> Html msg
viewValidation model =
  let
    (color, message) =
      if model.password /= model.passwordAgain then
        ("red", "Passwords do not match!")
      else if String.length model.password < 8 then
        ("red", "length > 8")
      else if (Regex.contains (Regex.regex "^(?=.*[a-z])+(?=.*[A-Z])+(?=.*\\d)") model.password) == False then
        ("red", "Password must contain an Uppercase, Lowercase letter and a number" )
      else
        ("green", "OK")
  in
    div [ style [("color", color)] ] [ text message ]

--abcdefgH1