%TODO fix hardcoded tipes and names of my default pokemon
%TODO list all my pokemon, to permit that user choose one of them.
%TODO create method to get first type of my pokemon

getListOfPokemons() :- 
	findall(PokemonName, (pokemon(_, PokemonName, _, _, _, _, _, _, _),(PokemonName=bulbasaur;PokemonName=shelmet;PokemonName=ditto;PokemonName=deino)), List),
	printPokemonsByEffectiveness(List).

printPokemonsByEffectiveness(List) :-
	printMegaEffectiveness(List);
	printSuperEffectiveness(List);
	printNormalEffectiveness(List);
	printZeroEffectiveness(List);
	printWeakness(List);
	printSuperWeakness(List).

printMegaEffectiveness([]).
printMegaEffectiveness([PokemonName|Rest]) :- (type(pokemon(PokemonName),EnemyPokemonType),mega_effectiveness(fire,EnemyPokemonType),
	write("Charizard has Mega Effectiveness against "),write(PokemonName),write(", a direct attack would cause damage multiplied by 4!"),nl);printMegaEffectiveness(Rest).

printSuperEffectiveness([]).
printSuperEffectiveness([PokemonName|Rest]) :- (type(pokemon(PokemonName),EnemyPokemonType),super_effectiveness(fire,EnemyPokemonType),
	write("Charizard has Super Effectiveness against "),write(PokemonName),write(", a direct attack would cause damage multiplied by 2! "),nl);printSuperEffectiveness(Rest).

printNormalEffectiveness([]).
printNormalEffectiveness([PokemonName|Rest]) :- (type(pokemon(PokemonName),EnemyPokemonType),normal_effectiveness(fire,EnemyPokemonType),
	write("Charizard has Normal Effectiveness against "),write(PokemonName),write(", then the attack has no bonus or decrease, and would be equal to attack points of "),write("Charizard."),nl);printNormalEffectiveness(Rest).

printZeroEffectiveness([]).
printZeroEffectiveness([PokemonName|Rest]) :- (type(pokemon(PokemonName),EnemyPokemonType),zero_effectiveness(fire,EnemyPokemonType),
	write("Charizard has Zero Effectiveness against "),write(PokemonName),write(", "),write(PokemonName),write(" is of type "),write(EnemyPokemonType),write(", that has immunity against attacks of fire type!"),nl);printZeroEffectiveness(Rest).

printWeakness([]).
printWeakness([PokemonName|Rest]) :- (type(pokemon(PokemonName),EnemyPokemonType),weakness(fire,EnemyPokemonType),
	write("Charizard has Weakness against "),write(PokemonName),write(", then the attack has decrease, and would be multiplied by 1/2!"),nl);printWeakness(Rest).

printSuperWeakness([]).
printSuperWeakness([PokemonName|Rest]) :- (type(pokemon(PokemonName),EnemyPokemonType),super_weakness(fire,EnemyPokemonType),
	write("Charizard has Super Weakness against "),write(PokemonName),write(", then the attack has super decrease, and would be multiplies by 1/4!"),nl);printSuperWeakness(Rest).

