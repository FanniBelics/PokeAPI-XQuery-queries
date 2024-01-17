(:Shows the highest stats of each Pokemon:)


xquery version '3.1';
declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "json";
declare option output:indent "yes";

let $poke_data := fn:json-doc("pokemon.json")?*,
    $pokemon_best_of := 
    for $pokemon in $poke_data
    let $stats := $pokemon ? stats ?*,
        $strongest := max($stats ! fn:max(?base_stat)),
        $strongest_stats := $stats[?base_stat eq $strongest]?stat?name
        return map{$pokemon("name"):
            array{
            for $strongest_stat in $strongest_stats
                return map{
                $strongest_stat : $strongest
                }
        }}
   return array{$pokemon_best_of}
   