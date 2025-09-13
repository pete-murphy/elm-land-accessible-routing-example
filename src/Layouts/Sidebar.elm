module Layouts.Sidebar exposing (Model, Msg, Props, layout)

import Accessibility.Aria as Aria
import Browser.Dom
import Effect exposing (Effect)
import Html exposing (Html)
import Html.Attributes as Attributes
import Layout exposing (Layout)
import Route exposing (Route)
import Route.Path
import Shared
import Task
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
        |> Layout.withOnUrlChanged UrlChanged



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
    = UrlChanged { from : Route (), to : Route () }
    | NoOp


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        UrlChanged { from, to } ->
            if from.path /= to.path then
                ( model
                , Effect.sendCmd
                    (Task.attempt
                        (\_ -> NoOp)
                        (Browser.Dom.focus "skip-link")
                    )
                )

            else
                ( model
                , Effect.none
                )

        NoOp ->
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
        [ Html.node "route-announcer"
            [ Attributes.attribute "message" ("Navigated to " ++ content.title)
            ]
            []
        , Html.a
            [ Attributes.class "absolute -top-full left-0 z-10 bg-white focus-visible:top-4 focus-visible:left-4 focus-visible:outline-2 focus-visible:outline-offset-2 motion-safe:transition-[outline-offset] focus-visible:outline-blue-600"
            , Attributes.id "skip-link"
            , Attributes.href "#content"
            , Attributes.target "_self"
            ]
            [ Html.text "Skip to content" ]
        , Html.div [ Attributes.class "grid grid-cols-[20ch_1fr] relative" ]
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
    Html.main_
        [ Attributes.class "p-4 prose focus-visible:outline-none"
        , Attributes.id "content"
        , Attributes.tabindex -1
        ]
        [ Html.header []
            [ Html.h1 []
                [ Html.text content.title ]
            ]
        , Html.div []
            content.body
        ]
