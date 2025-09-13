module Layouts.Sidebar exposing (Model, Msg, Props, layout)

import Accessibility.Aria as Aria
import Effect exposing (Effect)
import Html exposing (Html)
import Html.Attributes as Attributes
import Layout exposing (Layout)
import Route exposing (Route)
import Route.Path
import Shared
import View exposing (View)


type alias Props =
    {}


layout : Props -> Shared.Model -> Route () -> Layout () Model Msg contentMsg
layout _ _ route =
    Layout.new
        { init = init
        , update = update
        , view = view route
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    {}


init : () -> ( Model, Effect Msg )
init _ =
    ( {}
    , Effect.none
    )



-- UPDATE


type Msg
    = ReplaceMe


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        ReplaceMe ->
            ( model
            , Effect.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Route () -> { toContentMsg : Msg -> contentMsg, content : View contentMsg, model : Model } -> View contentMsg
view route { toContentMsg, model, content } =
    let
        navItem path name =
            Html.li []
                [ Html.a
                    [ Attributes.class "underline aria-[current=page]:font-bold"
                    , if route.path == path then
                        Aria.currentPage

                      else
                        Attributes.class ""
                    , Route.Path.href path
                    ]
                    [ Html.text name ]
                ]
    in
    { title = content.title
    , body =
        [ Html.div [ Attributes.class "grid grid-cols-[20ch_1fr] relative" ]
            [ Html.aside [ Attributes.class "bg-gray-100 p-4 sticky top-0 h-dvh" ]
                [ Html.nav []
                    [ Html.ul []
                        [ navItem Route.Path.Home_ "Home"
                        , navItem Route.Path.Zombies "Zombies"
                        , navItem Route.Path.Hipsters "Hipsters"
                        , navItem Route.Path.Bacon "Bacon"
                        ]
                    ]
                ]
            , mainContent content
            ]
        ]
    }


mainContent : View msg -> Html msg
mainContent content =
    Html.main_ [ Attributes.class "p-4 prose" ]
        [ Html.header []
            [ Html.h1 []
                [ Html.text content.title ]
            ]
        , Html.div []
            content.body
        ]
