(: This query creates a Pokemon card in HTML for a given pokemon :) 
xquery version '3.1';

import module namespace deik-utility = "http://www.inf.unideb.hu/xquery/utility"
at "https://arato.inf.unideb.hu/jeszenszky.peter/FejlettXML/lab/lab10/utility/utility.xquery";

declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "html";
declare option output:indent "yes";
declare option output:html-version "5.0";

declare function local:catch_pokemon($name as xs:string){
   let $uri := fn:concat("https://pokeapi.co/api/v2/pokemon/",$name)
    
    return fn:json-doc($uri)
};

let $given_pokemon := "piplup"
let $poke_data := local:catch_pokemon(fn:lower-case($given_pokemon))
let $name := $poke_data("name")
let $hp := $poke_data("stats")(1)("base_stat")
let $types := $poke_data?types?*
let $abilities := $poke_data?abilities?*
let $img := $poke_data?sprites?front_default

return document {
<html>
    <head>
            <title>{$name}</title>
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"/>
        </head>
        <body>
            <div class="card text-center text-bg-danger mb-3" style="width: 18rem;">
            <div class="card-header">
            <h5 class="card-text">{$name}</h5>
            <img src="{$img}" class="card-img-top" alt="Pokemon image"/>
            </div>
                <div class="card-body">
                 <h6 class="card-text">HP: {$hp}</h6>
                 <h6 class="card-text">Type: </h6>
                 <div class="card-text">
                    <ul class="list-group list-group-flush">
                        {for $type in $types
                        return document{
                            <li class="list-group-item">{$type?type?name}</li>
                        }
                    }
                    </ul>
                 </div>
                 <h6 class="card-text">Abilities: </h6>
                 <div class="card-text">
                    <ul class="list-group list-group-flush">
                        {for $abil in $abilities
                        return document{
                            <li class="list-group-item">{$abil?ability?name}</li>
                        }
                    }
                    </ul>
                 </div>
                </div>
            </div>
        </body>
</html>
}

