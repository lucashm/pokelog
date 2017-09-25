:- dynamic player/2.
:- [aux].
play() :-
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
        checkpokemon(Name, Pokemon).

retry(Name) :-
        write('Pokemon inválido!! Selecione um pokemon da lista:'),
        nl,
        write('pikachu'), nl,
        write('charizard'), nl,
        write('bulbassauro'), nl,
        read(Pokemon),
        checkpokemon(Name, Pokemon).


checkpokemon(Name, Pokemon) :- ifThenElse(ispokemon(Pokemon), setpokemon(Name, Pokemon), retry(Name)).


setpokemon(Name, Pokemon) :-
        assert(player(Name, pokemon(Pokemon))).


pokemon(pikachu).
pokemon(charizard).
pokemon(bulbassauro).



tipo_de_ataque(pikachu, raio).
