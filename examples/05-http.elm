import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Decode



main =
  Html.program
    { init = init "cats"
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL


type alias Model =
  { topic : String
  , gifUrl : String
  , errorMessage : Maybe String
  }


init : String -> (Model, Cmd Msg)
init topic =
  ( Model topic "waiting.gif" Nothing
  , getRandomGif topic
  )



-- UPDATE


type Msg
  = MorePlease
  | NewGif (Result Http.Error String)
  | NewTopic String


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    MorePlease ->
      (model, getRandomGif model.topic)

    NewGif (Ok newUrl) ->
      (Model model.topic newUrl (Just ""), Cmd.none)

    NewGif (Err _) ->
      (Model model.topic "" Nothing, Cmd.none)

    NewTopic topic ->
       ({ model | topic = topic}, Cmd.none)
      
      


displayMessage : Maybe String -> String
displayMessage msg =
   case msg of
     Nothing ->
       "Sorry there was an error with the connexion"
     Just msg ->
       ""
       
-- updateTopic : String 


-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ h2 [] [text model.topic]
    , button [ onClick MorePlease ] [ text "More Please!" ]
    , br [] []
    , img [src model.gifUrl] []
    , span [] [text (displayMessage model.errorMessage)]
    , input [type_ "text", onInput NewTopic  ] []
    ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none



-- HTTP


getRandomGif : String -> Cmd Msg
getRandomGif topic =
  let
    url =
      "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic
  in
    Http.send NewGif (Http.get url decodeGifUrl)


decodeGifUrl : Decode.Decoder String
decodeGifUrl =
  Decode.at ["data", "image_url"] Decode.string
