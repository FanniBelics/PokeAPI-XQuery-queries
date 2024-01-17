(: This query returns the pokemons for given type :)

xquery version '3.1';
declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "json";
declare option output:indent "yes";


let $type := "grass",
    $pokemon_data := fn:json-doc("pokemon.json")?*,
    $pokemons := for $pokemon in $pokemon_data
        let $name := $pokemon?name
        let $types_p := $pokemon ? types ?*
        where fn:exists(fn:index-of($types_p ? type ? name, $type))
        order by $name
        return map{"name": $name}

return map{concat($type, " type") :
    array{
        $pokemons
     },
     "count" : count($pokemons)
     }