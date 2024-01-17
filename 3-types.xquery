(: Creates XML file collecting pokemon by their type :)
xquery version '3.1';
import schema default element namespace "" at "types.xsd";


declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "xml";
declare option output:indent "yes";


let $pokemons_data := fn:json-doc("pokemon.json")?*

let $pokemons := document{
<pokemons>{
for $pokemon in $pokemons_data
let $types := $pokemon ? types ?* ?type?name
return document {
     for $type in $types
        return document
        {
            <pokemon>
                <name>{$pokemon?name}</name>
                <type>{$type}</type>
            </pokemon>
        }
    }
    }</pokemons>
}
return validate{document{
<types>{
    for $pokemon in $pokemons//pokemon
    let $type := $pokemon/type
    group by $type
    order by $type
    return document{
        <type name = "{$type}">
            {
                for $poke in $pokemon
                return document
                {
                    <pokemon>
                    {$poke/name/text()}
                    </pokemon>
                }
            }
       </type>
    }
}</types>
}}