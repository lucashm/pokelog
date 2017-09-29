membro(X,[X|_]).
membro(X,[_|Y]):- membro(X,Y).

getpokemonlist(L) :- findall(X, pokemon(X), L).

ispokemon(X):-
  getpokemonlist(List),
  membro(X, List).


ifThenElse(X,Y,_):- X,!,Y.
ifThenElse(_,_,Z):- Z.

setPlayer(Name) :-
    random_between(0,1000, X),
    random_between(0,1000, Y),
    assert( player(Name, position(X,Y)) ).

setEnemiesPosition() :-
    foreach(between(1,10,_), singleEnemyPosition()).


singleEnemyPosition() :-
    random_between(0,1000, X),
    random_between(0,1000, Y),
    random_between(0, 598, Z),
    findall(pokemon(A,B,C,D,E,F,G,H,I), pokemon(A, B, C, D, E, F, G, H, I), Lista),
    write(Lista),
    membro(pokemon(Z, _, _, _, _, _, _, _, _), Lista),
    assert(enemyPokemon(pokemon(Z, _, _, _, _, _, _, _, _), position(X,Y))).
