(: This query calculates BMI index for each pokemon :)
(: BMI : weight/height^2 :)

xquery version '3.1';
declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "json";
declare option output:indent "yes";


declare function local:BMI_value($value as xs:double){
    let $val := if ($value lt 2) then
                "Underweight"
                else if ($value gt 5) then
                "Overweight"
                else
                "Normal"
   return $val
};

let $poke_data := fn:json-doc("pokemon.json")?*,
    $poke_BMI := 
    for $pokemon in $poke_data
    let $weight := $pokemon("weight"),
        $height := $pokemon?height,
        $BMI := $weight div ($height * $height),
        $value := local:BMI_value($BMI)
        
        return map{
        $pokemon("name") : array{
        map{
        "BMI" : fn:format-number($BMI,"##.000"),
        "value" : $value
        }}}
   return array{$poke_BMI}