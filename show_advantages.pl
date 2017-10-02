getListOfPokemons(MyPokemons) :-
	nl,write("Escolha um dos pokemons para ser comparado!! Digite o nome:"),nl,printMyPokemons(MyPokemons),nl,read(ChoosedPokemon),type(pokemon(ChoosedPokemon),MyPokemonType),
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
	write(ChoosedPokemon),write(" tem Mega Efetividade contra "),write(PokemonName),write(", um ataque direto causaria dano multiplicado por 4!"),nl,fail.
printMegaEffectiveness(_,_,_).

printSuperEffectiveness(List,ChoosedPokemon,MyPokemonType) :- member(PokemonName,List),type(pokemon(PokemonName),EnemyPokemonType),super_effectiveness(MyPokemonType,EnemyPokemonType),
	write(ChoosedPokemon),write(" tem Super Efetividade contra "),write(PokemonName),write(", um ataque direto causaria dano multiplicado por 2! "),nl,fail.
printSuperEffectiveness(_,_,_).

printNormalEffectiveness(List,ChoosedPokemon,MyPokemonType) :- member(PokemonName,List),type(pokemon(PokemonName),EnemyPokemonType),normal_effectiveness(MyPokemonType,EnemyPokemonType),
	write(ChoosedPokemon),write(" tem Efetividade Normal contra "),write(PokemonName),write(", então não há bônus ou penalidades no ataque, e seria igual ao seus pontos de ataque!"),nl,fail.
printNormalEffectiveness(_,_,_).

printZeroEffectiveness(List,ChoosedPokemon,MyPokemonType) :- member(PokemonName,List),type(pokemon(PokemonName),EnemyPokemonType),zero_effectiveness(MyPokemonType,EnemyPokemonType),
	write(ChoosedPokemon),write(" tem Zero Efetividade contra "),write(PokemonName),write(", "),write(PokemonName),write(" é do tipo "),write(EnemyPokemonType),write(", que tem imunidade contra o tipo "),write(MyPokemonType),nl,fail.
printZeroEffectiveness(_,_,_).

printWeakness(List,ChoosedPokemon,MyPokemonType) :- member(PokemonName,List),type(pokemon(PokemonName),EnemyPokemonType),weakness(MyPokemonType,EnemyPokemonType),
	write(ChoosedPokemon),write(" tem Fraqueza contra "),write(PokemonName),write(", então o ataque será diminuido, causando apenas 1/2 do dano!"),nl,fail.
printWeakness(_,_,_).

printSuperWeakness(List,ChoosedPokemon,MyPokemonType) :- member(PokemonName,List),type(pokemon(PokemonName),EnemyPokemonType),super_weakness(MyPokemonType,EnemyPokemonType),
	write(ChoosedPokemon),write(" tem Super Fraqueza "),write(PokemonName),write(", então o ataque será super diminuido, causando apenas 1/4 do dano!"),nl,fail.
printSuperWeakness(_,_,_).
