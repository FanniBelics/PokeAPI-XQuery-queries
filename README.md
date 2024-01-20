# PokeAPI-XQuery-queries
As a homework project I created an adjustable query to collect data from [PokeAPI](https://pokeapi.co/) and created 9 more queries to sort the pokemons' data into different files
## 1. Query
This query sends a request to the API and collects the URLs to the first n pokemons based on your adjustments.
Then from the returned URLs the query requests the API again to collec each Pokemon's data one by one.
Parameters: 
- `limit_pokemon`: This parameter adjusts the amount of pokemons you'd like to request from the API
- `current_offset`: The offset parameter of the API declares the amount of pokemons you'd like to skip before requesting the first one
-Example: if you set `current_offset` to 3 and `limit_pokemon` to 10 you'll get the first 10 pokemon after the 4th one, which means the first Pokemon you're getting is Charmander, skipping Bulbasaur and it's evolutions

## 2. Pokecards
This query returns an XML document which holds the needed data for an oldschool Pokemon card
Contains: 
- Name
- HP
- Type
- Abilites

## 3. Types 
This query returns an XML document that holds the Pokemons categorized by their type.
If a Pokemon happens to have more than one type like Bellsprout (Grass, Poison) it appears in both lists.

## 4. Original
This query returns an XML file containing the original return of the PokeAPI.

## 5. Weight
This query returns a JSON file containing the Pokemons by their name, weight and abilities that are lighter than a given parameter. 
Perfect for "Lift the Pokedex" challenges 
Parameters: 
- `given_weight`: This parameter helps you adjust the maximum weight of the Pokemons. 

# 6. Longest names
This query returns a list of pokemons that have the longest names in the dataset. In case more pokemon in your dataset has names the same long as the other, all of them will be listed. 

# 7. Create custom card
This query returns with an HTML document that contains exactly one Pokemon card of your choice. 
The card is styled with Boothstrap's card class
Parameters: 
-`given_pokemon`: This parameter needs a name of a Pokemon that the card should be cerated about
The card contains the following parameters: 
- Name
- HP
- Type
- Abilites

## 8. Pokemons of a type
This query collects the Pokemons of a given type and returns them in a JSON file. Also retursn the count of the pokemons in the JSON file.
Parameters:
- `type`: Describes the type you are looking for (e.g.: grass, fire, fairy)

## 9. Best stats
Returns with the best stat of each Pokemon in the dataset based on their value. In case a pokemon has the same value for more stats a list is returned containing all the stats with name and value.
This query returns a JSON file. 

## 10. BMI
This query calculates the BMI index of each pokemon in a dataset and returns a JSON file containing each pokemon's category and their BMI index.
BMI is calculated with the following formula: weight/height^2^

The XML generating files come with their matching XSM file containing a schema for the produced XML file
