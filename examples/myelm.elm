import Html exposing (Html, button, div, text)
import Color exposing (..)
import Collage exposing (collage)
import Element exposing (..)
import Html.Events exposing (onClick)
-- import Math 

main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }

(gameWidth,gameHeight) = (600,400)
(halfWidth,halfHeight) = (300,200)


type alias Model =
    {    x   : Float
         ,y : Float
         ,angle : Float
         ,dir : Direction
    }

type Direction 
    = Left | Right

type Msg = 
    LEFT |
    RIGHT |
    FORWARDS 

model : Model
model = Model 0 0 0 Left 


update : Msg -> Model -> Model
update msg model =
    case msg of
      LEFT -> 
        {model | angle = model.angle + 20   }
      RIGHT ->
        { model | angle = model.angle - 20 }
      FORWARDS ->
        {model | x = model.x + moveAngleX model, y = model.y + moveAngleY model}

displayObj : Model  -> Collage.Shape -> Collage.Form
displayObj obj shape = 
    Collage.rotate  (degrees obj.angle) ( Collage.move (obj.x, obj.y) (Collage.filled black shape)) 
  
moveAngleX : Model -> Float
moveAngleX model =
   20 * cos ((model.angle - 90) * 0.1745)

moveAngleY : Model -> Float
moveAngleY model = 
   20 * sin ((model.angle - 90) * 0.1745)


view : Model -> Html Msg
view model =
    div [] [
        toHtml <|
        collage gameWidth gameHeight [
            displayObj model 
              <| Collage.rect 60 30
              --|> Collage.filled (Color.rgb 100 100 0)
        ],
         Html.text "HI"
         ,button [ onClick LEFT ] [ text "<" ]
         ,button [onClick FORWARDS ] [text "^"]
         ,button [ onClick RIGHT ] [ text ">" ]
          ]
