(: Transforms the content of the JSON file into XML files that contain the same information as old pokemon cards :) 

xquery version '3.1';
import schema default element namespace "" at "pokecards.xsd";

declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "xml";
declare option output:indent "yes";

let $pokemons := fn:json-doc("pokemon.json")?*
    return
    validate{
        document{
            <deck>
            <cards>
                {
                for $pokemon in $pokemons
                return 
                <card>
                    <name>{$pokemon("name")}</name>
                    <hp>{$pokemon("stats")(1)("base_stat")}</hp>
                    {
                       let $types := $pokemon?types?*
                       
                       for $type in $types
                       return
                       <type>
                       {$type("type")("name")}
                       </type>
                    }
                  <abilities>
                  {
                    let $abilities := $pokemon?abilities?*
                       
                       for $abil in $abilities
                       return
                       <type>
                       {$abil("ability")("name")}
                       </type>
                  }
                 </abilities>
                </card>
               }
            </cards>
            </deck>
    }}