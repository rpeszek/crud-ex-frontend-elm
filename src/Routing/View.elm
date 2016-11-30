module Routing.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Routing.Logic as Logic
import Reuse.Common.View as ViewC
import ElmRoutes as ElmR exposing (ElmRoute(..))

view : Logic.Model -> Html Logic.Msg
view model = div [] <| viewRoute model.route ++ viewRouteErr model.err

viewRoute : ElmRoute -> List (Html Logic.Msg)
viewRoute route = let header = case route of 
                ListThingsR  -> "Things List"
                CreateThingR  -> "Create New Thing"
                ViewThingR _ -> "Thing View" 
                EditThingR _ -> "Thing Edit" 
             in [div [] [h1 [] [text header]]]


viewRouteErr : Maybe String -> List (Html Logic.Msg)
viewRouteErr maybeErr = case maybeErr of
        Nothing -> []
        Just err -> [ViewC.viewErrorTxt err]
