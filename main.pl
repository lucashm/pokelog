:- dynamic player/2.
:- dynamic clearBase/1.
:- dynamic clearBase1/1.
:- dynamic enemyPokemon/2.
:- [aux].
:- [pokemons].
:- use_module(library(lists)).

ownedPokemon([]) :-
  fail.  % Usuário começa com uma lista vazia de pokemons

play() :-
        clearBase(enemyPokemon(Pokemon)),
        setEnemiesPosition(),
        write('Digite o seu nome:'),
        nl,
        read(Name),
        setPlayer(Name),
        nl,
        menu().

menu() :-
  write('Digite a opção dejada:'),
  nl,
  write('1- Cadastrar um pokemon'),
  nl,
  write('2- Listar meus pokemons'),
  nl,
  write('3- Verificar minha posição no mapa'),
  nl,
  write('4- Buscar o melhor campo para treino'),
  nl,
  read(Choice),
  option(Choice).


option(1) :-
    choosePokemon().

option(2) :-
    findall(X, ownedPokemon(X), L),
    write(L),
    nl, nl,
    menu().

option(3) :-
    findall((X,Y), player(X,Y), L),
    nl, write('sua Posição é: '),
    write(L),
    nl, nl,
    menu().

choosePokemon() :-
        write('Que pokemon você tem?'),
        nl,
        read(Pokemon),
        checkpokemon(Pokemon).

retry() :-
        write('Pokemon inválido!! Digite o nome do seu pokemon corretamente'),
        nl,
        read(Pokemon),
        checkpokemon(Pokemon).


checkpokemon(Pokemon) :- ifThenElse(ispokemon(Pokemon), setpokemon(Pokemon), retry()).


setpokemon(Pokemon) :-
        assert(ownedPokemon(pokemon(Pokemon))),
        menu().


%TODO:fix the singletons on clearBase and clearBase1
clearBase(Pokemon):- clearBase1(Pokemon), fail.
clearBase(Pokemon).

clearBase1(Pokemon):- retract(Pokemon).
clearBase1(Pokemon).

tipo_de_ataque(pikachu, raio). %exemplo
