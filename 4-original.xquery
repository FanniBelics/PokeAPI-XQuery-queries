(: This query lists the original content of the pokeAPI I used to collect my current dataset :)
xquery version '3.1';
import module namespace deik-utility = "http://www.inf.unideb.hu/xquery/utility"
at "https://arato.inf.unideb.hu/jeszenszky.peter/FejlettXML/lab/lab10/utility/utility.xquery";

import schema default element namespace "" at "original.xsd";
declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "xml";
declare option output:indent "yes";

declare function local:get_pokemon_range($offset as xs:integer, $limit as xs:integer)
{
    let $uri := deik-utility:add-query-params("https://pokeapi.co/api/v2/pokemon",
    map{
        "offset": $offset,
        "limit": $limit
        }
    )
    let $data := fn:json-doc($uri)("results")
    return if (array:size($data)>1) then
         array:join(($data, local:get_pokemon_range($offset+$limit, $limit)))
    else 
         []
};

let $limit_pokemon := 20
let $current_offset := 0

let $data := local:get_pokemon_range($current_offset, $limit_pokemon)

return validate{document{
<pokemons>
{for $element in $data?*
return document{
<pokemon name = "{$element("name")}">{$element("url")}</pokemon>
}}
</pokemons>
}}

