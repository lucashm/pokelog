:- dynamic player/2.
play :-
        write('Digite o seu nome:'),
        nl,
        read(Name),
        nl,
        write('Digite o pokemon escolhido! Opções:'),
        nl,
        write('pikachu'), nl,
        write('charizard'), nl,
        write('bulbassauro'), nl,
        read(Pokemon),
        selectPokemon(Name, Pokemon).


selectPokemon(Name, Pokemon) :- assert(player(Name, pokemon(Pokemon))).

membro(X,[X|_]).
membro(X,[_|Y]):- membro(X,Y).

ismember(X):-
  pokemons(List),
  membro(X, List). %or member1 if we need to define membership rule


pokemons(L) :- findall(X, pokemon(X), L).

pokemon(pikachu).
pokemon(charizard).
pokemon(bulbassauro).



tipo_de_ataque(pikachu, raio).
