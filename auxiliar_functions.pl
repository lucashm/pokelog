membro(X,[X|_]).
membro(X,[_|Y]):- membro(X,Y).


getpokemonlist(L) :- findall(X, pokemon(_,X, _, _, _, _, _, _, _), L).

ispokemon(X):-
  getpokemonlist(List),
  membro(X, List).


ifThenElse(X,Y,_):- X,!,Y.
ifThenElse(_,_,Z):- Z.

printPokemon(Id, Name, Hp, Attack, Def, SpA, SpD, Spe, Total) :-
  nl, nl,
  write(Name), write('- id:'), write(Id), nl,
  write('-------STATUS-------'), nl,
  write('HP: '), write(Hp), nl,
  write('Attack: '), write(Attack), nl,
  write('Defense: '), write(Def), nl,
  write('SpA: '), write(SpA), nl,
  write('SpD: '), write(SpD), nl,
  write('Spe: '), write(Spe), nl,
  write('Total:'), write(Total), nl,
  write('--------------------'), nl, nl.

setPlayer(Name) :-
    random_between(0,1000, X),
    random_between(0,1000, Y),
    assert( player(Name, position(X,Y)) ).

setEnemiesPosition() :-
    clearBase(enemyPokemon(_, _)), %cleaning enemies setted before
    foreach(between(1,40,_), singleEnemyPosition()).


singleEnemyPosition() :-
    random_between(0,1000, X), %getting random X axis
    random_between(0,1000, Y), %getting random Y axis
    random_between(0, 598, Z), %getting random Pokemon
    findall(pokemon(A,B,C,D,E,F,G,H,I), pokemon(A, B, C, D, E, F, G, H, I), Lista), %getting pokemon list
    nth1(Z, Lista, ChosenOne), %getting one element in the list | Element = Z = Random Pokemon
    assert(enemyPokemon(ChosenOne, position(X,Y))). %asserting enemyPokemon in the map

scanEnemies(Xp,Yp) :-
    findall((Pokemon, Position), enemyPokemon(Pokemon, Position), Enemies),
    foreach(membro((Pokemon, position(X,Y)), Enemies), getEnemiesNearby(Pokemon, X,Y,Xp,Yp)).

getEnemiesNearby(Pokemon, X,Y,Xp,Yp) :-
    %That is the distance between the player(Xp,Yp) and the EnemyPokemon(X, Y):
    D is sqrt(  ( Xp - X )*( Xp - X ) + ( Yp - Y )*( Yp - Y )  ),

    ifThenElse( D < 250, %The player's range is 250
               assert( nearbyEnemy( Pokemon, position(X,Y) ) ) ,  % <-- if the enemy is close
               true  ).  % <-- does nothing if the enemy is far

printNearPokemons() :-
    findall((PokemonName, X, Y),nearbyEnemy(pokemon(_, PokemonName, _, _, _, _, _, _, _),position(X,Y)),ListOfNearbyNemeies),
    foreach(membro((PokemonName, X, Y), ListOfNearbyNemeies), (  write("Um "), write(PokemonName), write( " encontrado por perto. Posição: "), write(X), write(', '), write(Y), nl ) ).
