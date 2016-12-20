module Thing.Combined.View exposing (..)

import Html as Html exposing (Html)
import Html.Attributes exposing (..)
import ElmRoutes exposing (ElmRoute(..))
import Thing.Combined.Logic as Logic 
import Thing.Edit.View as Edit
import Thing.Read.View as Read
import Thing.List.View as List

viewForRoute : ElmRoute -> Logic.Model -> Html Logic.Msg
viewForRoute route model = case route of 
    ListThingsR  -> Html.map Logic.ListMsg <| List.view model.listM
    CreateThingR -> Html.map Logic.EditMsg <| Edit.view model.editM
    ViewThingR _ -> Html.map Logic.ReadMsg <| Read.view model.readM
    EditThingR _ -> Html.map Logic.EditMsg <| Edit.view model.editM
