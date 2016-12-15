import Html exposing (..)
import Html.Events exposing (..)
import Random



main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL


type alias Model =
  { dieFace : Int
  }


init : (Model, Cmd Msg)
init =
  (Model 1, Cmd.none)



-- UPDATE


type Msg
  = Roll
  | NewFace Int


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      (model, Random.generate NewFace (Random.int 1 6))

    NewFace newFace ->
      (Model newFace, Cmd.none)


sweetFunc : Int -> List Int
sweetFunc n = 
  if n <= 0 then
    [0]
  else  sweetFunc (n-1) ++ [n]

-- sweetRan : Int -> List Int
-- sweetRan n = 
--    if n <= 0 then
--      [ Random.generate (Random.int 1 6) ]
--    else sweetFunc (n-1) ++ [n]

intList : Random.Generator (List Int)
intList =
    Random.list 5 (Random.int 0 100)

ranList :  Random.Generator (List Int) -> List Int
ranList = 
  Random.generate intList



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ h1 [] [ text (toString model.dieFace) ]
    , button [ onClick Roll ] [ text "Roll" ]
    , ul [] (List.map (\l -> li [] [ text (toString l)]) (sweetFunc 4) )
    , ul [] (List.map (\l -> li [] [ text (toString l)]) (intList) )
    ]
