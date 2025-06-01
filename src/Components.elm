module Components exposing (..)

import Html
import Html.Attributes as Attrs


primaryBtnCls : String
primaryBtnCls =
    "py-2 px-4 text-white bg-indigo-600 hover:bg-indigo-700 cursor-pointer rounded-md text-lg"


secondaryBtnCls : String
secondaryBtnCls =
    "py-2 px-4 text-indigo-700 border-1 border-indigo-600 bg-white hover:bg-neutral-100 cursor-pointer rounded-lg text-sm"


viewButton : { text : String, class : String, event : Html.Attribute msg } -> Html.Html msg
viewButton d =
    Html.button [ d.event, Attrs.class d.class ]
        [ Html.text d.text
        ]
