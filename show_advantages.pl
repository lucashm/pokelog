%TODO change variables with correct attibutes names
%TODO list all my pokemon, to permit that user choose one of them.
%TODO create method to get first type of my pokemon

getListOfPokemons() :- 
	findall(PokemonName, (pokemon(_, PokemonName, _, _, _, _, _, _, _),(PokemonName=bulbasaur;PokemonName=shelmet;PokemonName=ditto;PokemonName=deino)), Lista),
	printPokemonsByEffectiveness(Lista).

printPokemonsByEffectiveness(Lista) :-
	printMegaEffectiveness(Lista).

%verifyIfHaveMegaAdvantage(Lista) :-
printMegaEffectiveness([]).
printMegaEffectiveness([PokemonName|Rest]) :- type(pokemon(PokemonName),EnemyPokemonType),mega_effectiveness(fire,EnemyPokemonType),
	write("Charizard has mega Effectiveness against "),write(PokemonName),nl,printMegaEffectiveness(Rest).

