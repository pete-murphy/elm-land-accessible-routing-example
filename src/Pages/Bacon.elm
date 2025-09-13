module Pages.Bacon exposing (Model, Msg, page)

import Effect exposing (Effect)
import Html
import Html.Attributes
import Layouts
import Page exposing (Page)
import Route exposing (Route)
import Shared
import View exposing (View)


page : Shared.Model -> Route () -> Page Model Msg
page shared route =
    Page.new
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
        |> Page.withLayout
            (\_ -> Layouts.Sidebar {})



-- INIT


type alias Model =
    {}


init : () -> ( Model, Effect Msg )
init () =
    ( {}
    , Effect.none
    )



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        NoOp ->
            ( model
            , Effect.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> View Msg
view model =
    { title = "Bacon"
    , body =
        [ Html.p []
            [ Html.text "Bacon ipsum dolor amet alcatra ham tongue landjaeger brisket flank. Tenderloin turkey pork chop beef alcatra, rump andouille spare ribs prosciutto chicken burgdoggen. Andouille ribeye sirloin tenderloin, pig flank boudin alcatra shank ball tip landjaeger strip steak short ribs leberkas tri-tip. Shankle pork loin pork chop drumstick turducken ham hock. Hamburger spare ribs rump, bacon porchetta kielbasa jowl tail venison shoulder pastrami frankfurter drumstick. Biltong cow salami leberkas tail. Meatball corned beef cupim, boudin pastrami rump sirloin turkey drumstick tenderloin bacon tri-tip." ]
        , Html.p []
            [ Html.text "Salami biltong pig "
            , Html.a
                [ Html.Attributes.href "#"
                ]
                [ Html.text "hamburger meatball" ]
            , Html.text ". Meatball ham kevin leberkas. Cupim cow sausage porchetta. Flank chicken ham hock beef ribs tongue. Kielbasa pork belly porchetta prosciutto ribeye burgdoggen pork loin frankfurter bacon beef ribs. Pancetta pork loin cow flank, cupim pastrami pig prosciutto. Jerky spare ribs tongue brisket cupim ham hock bresaola landjaeger ball tip corned beef tail filet mignon. Tenderloin turducken swine, bresaola corned beef sausage filet mignon burgdoggen frankfurter pork loin pork chop strip steak chuck shoulder boudin. Meatball pork belly andouille pastrami t-bone tri-tip, rump short ribs shoulder beef ribs burgdoggen turkey kielbasa."
            ]
        , Html.p []
            [ Html.text "Salami tri-tip beef ribs drumstick capicola jowl turkey, filet mignon brisket short ribs jerky pig landjaeger. Short ribs strip steak flank filet mignon shankle kevin jowl capicola tri-tip. Porchetta spare ribs shank ribeye tri-tip. Turkey porchetta t-bone bacon fatback. Jerky drumstick brisket capicola prosciutto beef ribs jowl meatball chuck fatback. Chicken tenderloin sausage ham shoulder burgdoggen ball tip tri-tip spare ribs chuck beef pancetta shank alcatra pig. Ground round frankfurter burgdoggen jowl leberkas sirloin. Ball tip cow short ribs, meatball landjaeger brisket cupim jerky shankle. Cupim hamburger pig beef ribs, swine meatball cow." ]
        ]
    }
