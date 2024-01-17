(:Collect given amount of Pokémon from API with pagination:)
xquery version "3.1";

import module namespace deik-utility = "http://www.inf.unideb.hu/xquery/utility"
at "https://arato.inf.unideb.hu/jeszenszky.peter/FejlettXML/lab/lab10/utility/utility.xquery";

declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace http = "http://expath.org/ns/http-client";
declare option output:method "json";
declare option output:indent "yes";

declare function local:collect_pokemon($offset as xs:integer, $limit_pokemon as xs:integer){
let $uri := deik-utility:add-query-params("https://pokeapi.co/api/v2/pokemon",
    map{
        "offset": $offset,
        "limit": $limit_pokemon
        }
    )
    
    return fn:json-doc($uri)
};


declare function local:get_pokemon_data($url as xs:string){
    let $data := fn:json-doc($url)
    
    return $data
};

declare function local:get_all_pokemon($current_offset as xs:integer, $limit_pokemon as xs:integer, $n as xs:integer)
{
    let $pokemon_data := local:collect_pokemon($current_offset, $limit_pokemon)("results")
    let $data := [local:get_pokemon_data($pokemon_data($n)("url"))]
    return if ($n <= $limit_pokemon) then 
        array:join(($data, local:get_all_pokemon($current_offset, $limit_pokemon, $n+1)))
        else
            []
        
};

(: This can be adjusted based on your computer's performance :)
let $limit_pokemon := 20
let $current_offset := 0

return local:get_all_pokemon($current_offset, $limit_pokemon, 1)

