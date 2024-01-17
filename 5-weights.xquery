(: This query creates an XML files from the pokemon that are lighter than given weight and their abilities :)

xquery version '3.1';
import schema default element namespace "" at "weight.xsd";

declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "xml";
declare option output:indent "yes";

let $given_weight := 81,
    $pokemon_data := fn:json-doc("pokemon.json")?*

return validate {document{
<pokemons>{
for $pokemon in $pokemon_data
where $pokemon("weight") le $given_weight
order by $pokemon("weight")
return document{
    <pokemon>
        <name>{$pokemon("name")}</name>
        <weight>{$pokemon("weight")}</weight>
        <abilities>
        {
            let $abilities := $pokemon ? abilities ?*
            for $ability in $abilities ? ability ? name
            where fn:lower-case($ability) ne "flee" and fn:lower-case($ability) ne "run-away" 
            order by $ability
            return document{
                <ability>
                {$ability}
                </ability>
            }
        }
        </abilities>
    </pokemon>
    }
}</pokemons>
}}