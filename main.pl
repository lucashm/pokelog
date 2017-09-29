:- dynamic player/2.
:- [aux].

ownedPokemon([]) :-
  false.  % Usuário começa com uma lista vazia de pokemons

play() :-
        write('Digite o seu nome:'),
        nl,
        read(Name),
        assert(player(Name)),
        nl,
        menu().

menu() :-
  write('Digite a opção dejada:'),
  nl,
  write('1- Cadastrar um pokemon'),
  nl,
  write('2- Listar meus pokemons'),
  nl,
  write('3- Buscar o melhor campo para treino'),
  nl,
  read(Choice),
  option(Choice).


option(1) :-
    choosePokemon().

option(2) :-
    findall(X, ownedPokemon(X), L),
    write(L),
    nl,
    menu().

choosePokemon() :-
        write('Digite o pokemon escolhido! Opções:'),
        nl,
        write('pikachu'), nl,
        write('charizard'), nl,
        write('bulbassauro'), nl,
        read(Pokemon),
        checkpokemon(Pokemon).

retry() :-
        write('Pokemon inválido!! Selecione um pokemon da lista:'),
        nl,
        write('pikachu'), nl,
        write('charizard'), nl,
        write('bulbassauro'), nl,
        read(Pokemon),
        checkpokemon(Pokemon).


checkpokemon(Pokemon) :- ifThenElse(ispokemon(Pokemon), setpokemon(Pokemon), retry()).


setpokemon(Pokemon) :-
        assert(ownedPokemon(pokemon(Pokemon))),
        menu().


pokemon(pikachu).
pokemon(charizard).
pokemon(bulbassauro).



tipo_de_ataque(pikachu, raio). %exemplo
