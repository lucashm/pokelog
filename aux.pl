membro(X,[X|_]).
membro(X,[_|Y]):- membro(X,Y).

getpokemonlist(L) :- findall(X, pokemon(X), L).

ispokemon(X):-
  getpokemonlist(List),
  membro(X, List).


ifThenElse(X,Y,_):- X,!,Y.
ifThenElse(_,_,Z):- Z.
