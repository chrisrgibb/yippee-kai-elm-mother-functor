import Html exposing (Html, button, div, text)

main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }