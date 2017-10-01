getListOfPokemons(MyPokemons) :-
	nl,write("Choose one of yours Pokemons to be compared:"),nl,printMyPokemons(MyPokemons),nl,read(ChoosedPokemon),type(pokemon(ChoosedPokemon),MyPokemonType),
	split_string(MyPokemonType,"_","",Types),nth0(0,Types,PokemonTypeRecovered),atom_string(PokemonTypeSplitted,PokemonTypeRecovered),
	findall(PokemonName,nearbyEnemy(pokemon(_, PokemonName, _, _, _, _, _, _, _),_),List),
	printPokemonsByEffectiveness(List,ChoosedPokemon,PokemonTypeSplitted),nl,nl.

printMyPokemons([]).
printMyPokemons([MyPokemon|Rest]) :-
	tab(1),write(" -- "),write(MyPokemon),nl,printMyPokemons(Rest).

printPokemonsByEffectiveness(List,ChoosedPokemon,MyPokemonType) :-
	printMegaEffectiveness(List,ChoosedPokemon,MyPokemonType),
	printSuperEffectiveness(List,ChoosedPokemon,MyPokemonType),
	printNormalEffectiveness(List,ChoosedPokemon,MyPokemonType),
	printZeroEffectiveness(List,ChoosedPokemon,MyPokemonType),
	printWeakness(List,ChoosedPokemon,MyPokemonType),
	printSuperWeakness(List,ChoosedPokemon,MyPokemonType).

printMegaEffectiveness(List,ChoosedPokemon,MyPokemonType) :- member(PokemonName,List),type(pokemon(PokemonName),EnemyPokemonType),mega_effectiveness(MyPokemonType,EnemyPokemonType),
	write(ChoosedPokemon),write(" has Mega Effectiveness against "),write(PokemonName),write(", a direct attack would cause damage multiplied by 4!"),nl,fail.
printMegaEffectiveness(_,_,_).

printSuperEffectiveness(List,ChoosedPokemon,MyPokemonType) :- member(PokemonName,List),type(pokemon(PokemonName),EnemyPokemonType),super_effectiveness(MyPokemonType,EnemyPokemonType),
	write(ChoosedPokemon),write(" has Super Effectiveness against "),write(PokemonName),write(", a direct attack would cause damage multiplied by 2! "),nl,fail.
printSuperEffectiveness(_,_,_).

printNormalEffectiveness(List,ChoosedPokemon,MyPokemonType) :- member(PokemonName,List),type(pokemon(PokemonName),EnemyPokemonType),normal_effectiveness(MyPokemonType,EnemyPokemonType),
	write(ChoosedPokemon),write(" has Normal Effectiveness against "),write(PokemonName),write(", then the attack has no bonus or decrease, and would be equal to total attack points!"),nl,fail.
printNormalEffectiveness(_,_,_).

printZeroEffectiveness(List,ChoosedPokemon,MyPokemonType) :- member(PokemonName,List),type(pokemon(PokemonName),EnemyPokemonType),zero_effectiveness(MyPokemonType,EnemyPokemonType),
	write(ChoosedPokemon),write(" has Zero Effectiveness against "),write(PokemonName),write(", "),write(PokemonName),write(" is of type "),write(EnemyPokemonType),write(", that has immunity against attacks of "),write(MyPokemonType),write(" type!"),nl,fail.
printZeroEffectiveness(_,_,_).

printWeakness(List,ChoosedPokemon,MyPokemonType) :- member(PokemonName,List),type(pokemon(PokemonName),EnemyPokemonType),weakness(MyPokemonType,EnemyPokemonType),
	write(ChoosedPokemon),write(" has Weakness against "),write(PokemonName),write(", then the attack has decrease, and would be multiplied by 1/2!"),nl,fail.
printWeakness(_,_,_).

printSuperWeakness(List,ChoosedPokemon,MyPokemonType) :- member(PokemonName,List),type(pokemon(PokemonName),EnemyPokemonType),super_weakness(MyPokemonType,EnemyPokemonType),
	write(ChoosedPokemon),write(" has Super Weakness against "),write(PokemonName),write(", then the attack has super decrease, and would be multiplies by 1/4!"),nl,fail.
printSuperWeakness(_,_,_).

