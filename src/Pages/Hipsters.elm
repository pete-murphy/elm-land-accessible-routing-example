module Pages.Hipsters exposing (Model, Msg, page)

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
    { title = "Hipsters"
    , body =
        [ Html.p []
            [ Html.text "Butcher aesthetic photo booth coloring book lumbersexual squid banjo kogi shaman hella jean shorts. Photo booth prism polaroid, seitan PBR&B iceland irony you probably haven't heard of them. Mustache cold-pressed disrupt flexitarian lyft XOXO. Chillwave humblebrag authentic green juice XOXO la croix copper mug cardigan. Listicle salvia gentrify poutine, selfies messenger bag art party semiotics. Stumptown cloud bread sriracha banjo leggings hell of. Before they sold out cornhole intelligentsia pop-up narwhal mumblecore vice pabst tousled celiac franzen cold-pressed shabby chic ethical brooklyn. Sriracha humblebrag migas everyday carry." ]
        , Html.p []
            [ Html.text "Affogato 3 "
            , Html.a
                [ Html.Attributes.href "#"
                ]
                [ Html.text "wolf moon" ]
            , Html.text " mumblecore kale chips tilde. Gochujang cold-pressed trust fund, palo santo irony activated charcoal la croix try-hard unicorn heirloom vegan beard iPhone gastropub. Master cleanse locavore gluten-free edison bulb cold-pressed activated charcoal, kitsch chia single-origin coffee roof party lomo pour-over vape pork belly waistcoat. Fingerstache gochujang forage, offal poutine meh brunch lyft schlitz enamel pin readymade. Yuccie food truck plaid next level glossier dreamcatcher. Ennui forage swag, vape flannel photo booth normcore brooklyn etsy. Scenester deep v shoreditch single-origin coffee, snackwave chia hot."
            ]
        , Html.p []
            [ Html.text "Roof party gluten-free drinking vinegar kogi activated charcoal. Activated charcoal 8-bit prism chartreuse. Letterpress poutine DIY tattooed kinfolk migas. Narwhal kitsch pork belly paleo everyday carry helvetica you probably haven't heard of them asymmetrical lyft quinoa photo booth fanny pack 8-bit humblebrag cloud bread. Helvetica ugh XOXO quinoa. Lomo cronut hot chicken, distillery try-hard poke palo santo. Cliche 90's pickled flexitarian kinfolk. Vinyl ethical quinoa leggings offal gochujang before they sold out. Forage cornhole ethical pug hella wayfarers 3 wolf moon cred quinoa. Truffaut synth hexagon, hammock ramps bushwick." ]
        ]
    }
