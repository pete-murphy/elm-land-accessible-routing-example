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
    | ElmAttemptedFocus (Result Browser.Dom.Error ())


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        UrlChanged { from, to } ->
            if from.path /= to.path then
                ( model
                , Effect.sendCmd
                    (Task.attempt
                        ElmAttemptedFocus
                        (Browser.Dom.focus "skip-to-main-nav-link")
                    )
                )

            else
                ( model
                , Effect.none
                )

        ElmAttemptedFocus _ ->
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
                    [ Attributes.class "inline-block px-5 py-3 font-semibold aria-[current=page]:bg-blue-800 aria-[current=page]:text-white"
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
            [ Attributes.class "absolute -top-20 z-10 p-4 font-semibold bg-white focus-visible:top-0 motion-safe:transition-[outline-offset] focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600"
            , Attributes.id "skip-link"
            , Attributes.href "#content"
            , Attributes.target "_self"
            ]
            [ Html.text "Skip to content" ]
        , Html.div [ Attributes.class "grid" ]
            [ Html.header [ Attributes.class "p-2" ]
                [ Html.nav [ Attributes.id "main-nav" ]
                    [ Html.ul [ Attributes.class "flex" ]
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
        [ Attributes.class "p-4 pt-16 focus-visible:outline-none prose"
        , Attributes.id "content"
        , Attributes.tabindex -1
        ]
        [ Html.header []
            [ Html.a
                [ Attributes.id "skip-to-main-nav-link"
                , Attributes.href "#main-nav"
                , Attributes.target "_self"
                , Attributes.class "text-nowrap focus-outline"
                ]
                [ Html.text "Skip to main navigation" ]
            , Html.h1 []
                [ Html.text content.title ]
            ]
        , Html.div []
            content.body
        ]
