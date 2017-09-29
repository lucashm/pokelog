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
    assert( player(Name, playerPosition(X,Y)) ).

setEnemiesPosition() :-
    foreach(between(1,10,_), singleEnemyPosition()).


singleEnemyPosition() :-
    random_between(0,1000, X),
    random_between(0,1000, Y),
    assert(enemyPosition(X,Y)).
