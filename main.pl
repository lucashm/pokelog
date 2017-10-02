:- dynamic player/2.
:- dynamic clearBase/1.
:- dynamic clearBase1/1.
:- dynamic enemyPokemon/2.
:- [auxiliar_functions].
:- dynamic ownedPokemon/1.
:- [auxiliar_functions].
:- [pokemons].
:- use_module(library(lists)).
:- [effectiveness_by_type].
:- [show_advantages].
:- [attack_types].

ownedPokemon([]) :-
  fail.  % Usuário começa com uma lista vazia de pokemons

play() :-
        clearBase(enemyPokemon(_)),
        setEnemiesPosition(),
        write('Digite o seu nome:'),
        nl,
        read(Name),
        setPlayer(Name),
        nl,
        findall((X,Y), player(X,Y), L),
        foreach(membro((_,position(X,Y)), L), scanEnemies(X,Y)),
        menu().

menu() :-
  write('Digite a opção desejada:'),
  nl,
  write('1- Cadastrar um pokemon'),
  nl,
  write('2- Listar meus pokemons'),
  nl,
  write('3- Verificar minha posição no mapa'),
  nl,
  write('4- Procurar inimigos por perto'),
  nl,
  read(Choice),
  option(Choice).


option(1) :-
    choosePokemon().

option(2) :-
    findall(X, ownedPokemon(X), L),
    foreach(membro(pokemon(V1, V2, V3, V4, V5, V6, V7, V8, V9), L), printPokemon(V1, V2, V3, V4, V5, V6, V7, V8, V9)),
    nl, nl,
    menu().

option(3) :-
    findall((X,Y), player(X,Y), L),
    nl, write('sua Posição é: '),
    write(L),
    nl, nl,
    menu().

option(4) :-
    nl,
    printNearPokemons(),
    findall(X, ownedPokemon(X), List),
		getListOfPokemons(List),
    menu().

choosePokemon() :-
        write('Que pokemon você tem?'),
        nl,
        read(Pokemon),
        checkpokemon(Pokemon).

printPokemon() :-
    write('O Pokemon '),
    write(V2),
    write(' tem o código '),
    write(V1),
    write(' e as seguintes qualidades: '),
    nl,
    write('X: '),
    write(V3),
    nl,
    write('X: '),
    write(V4),
    nl,
    write('X: '),
    write(V5),
    nl,
    write('X: '),
    write(V6),
    nl,
    write('X: '),
    write(V7),
    nl,
    write('X: '),
    write(V8),
    nl,
    write('X: '),
    write(V9),
    nl.

retry() :-
        write('Pokemon inválido!! Digite o nome do seu pokemon corretamente'),
        nl,
        read(Pokemon),
        checkpokemon(Pokemon).


checkpokemon(Pokemon) :- ifThenElse(ispokemon(Pokemon), setpokemon(Pokemon), retry()).


setpokemon(Pokemon) :-
		findall(pokemon(A,Pokemon,C,D,E,F,G,H,I), pokemon(A, Pokemon, C, D, E, F, G, H, I) , Lista), %returns a list with only 1 element
		nth1(1, Lista, ChosenOne), %set this element to be a single pokemon funtor
        assert(ownedPokemon(ChosenOne)), %set this element to be in the list of owned pokemons
        menu(). %reopens menu


%TODO:fix the singletons on clearBase and clearBase1
clearBase(Pokemon):- clearBase1(Pokemon), fail.
clearBase(_).

clearBase1(Pokemon):- retract(Pokemon).
clearBase1(_).

tipo_de_ataque(pikachu, raio). %exemplo
