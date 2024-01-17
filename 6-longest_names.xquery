(: This query returns the names of the pokemons with the longest names in the dataset :) 

xquery version '3.1';

declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace json = "http://www.json.org";
declare option output:method "json";
declare option output:media-type "application/json";

let $poke_data := fn:json-doc("pokemon.json")?*,
    $longest_name_length :=  $poke_data ! fn:string-length(?name) => fn:max(),
    $longest_name_pokemon := $poke_data[fn:string-length(?name) eq $longest_name_length]
    
    let $ordered_names := for $pokemon in $longest_name_pokemon
                            let $name := $pokemon?name
                            order by $name
                            return $name
                            
    
    return
    map{"longest_names":
    array{
    for $name in $ordered_names
    return map{
        "name" : $name
    }
    }}

