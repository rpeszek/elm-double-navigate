module Main exposing (..)

import Navigation as Nav
import Task
import Html exposing (..)
import Html.Events exposing (onClick)

main : Program Never Model Msg
main = Nav.program (\loc -> DispatchUrlMsg <| Debug.log "got location" loc.hash)
   {
     init = (\loc -> (emptyModel, pure <| DispatchUrlMsg <| Debug.log "got location" loc.hash))
     , update = (\msg model -> case msg of
                   DispatchUrlMsg url -> (emptyModel, Cmd.none)
                   GotoUrlMsg url -> (emptyModel, Nav.newUrl <| Debug.log "nav to " url))
     , view = always showView
     , subscriptions = always Sub.none
    }

type Msg = DispatchUrlMsg String | GotoUrlMsg String

type alias Model = ()

emptyModel : Model
emptyModel = ()

showView : Html Msg 
showView = div[] [
  button [onClick <| GotoUrlMsg "#"] [text "Root"],
  Html.form [] [ 
       button [onClick <| GotoUrlMsg "#url2"] [text "Url2"]
  --   Html.fieldset [] ( 
  --      [ button [onClick <| GotoUrlMsg "#url2"] [text "Url2"] ])
  ] 
 ]

pure : a -> Cmd a 
pure x = Task.perform identity (Task.succeed x)
