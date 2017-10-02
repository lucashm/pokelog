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
  write('4- Mover-me no mapa'),
  nl,
  write('5- Procurar inimigos por perto'),
  nl,
  read(Choice),
  option(Choice).


option(1) :-
    choosePokemon().

option(2) :-
    findall(X, ownedPokemon(X), Lista),
    foreach(membro(pokemon(Id, Name, Hp, Attack, Def, SpA, SpD, Spe, Total), Lista), printPokemon(Id, Name, Hp, Attack, Def, SpA, SpD, Spe, Total)),
    nl, nl,
    menu().

option(3) :-
    findall((X,Y), player(X,Y), L),
    nl, write('Sua posição é: '),
    write(L),
    nl, nl,
    menu().

option(4) :-
    findall(player(X,Y), player(X, Y), L),
    nth1(1, L, ChosenOne),
    write('Sua posição atual é: '),
    write(ChosenOne), nl, nl,
    moveMenu(ChosenOne).

option(5) :-
    nl,
    printNearPokemons(),
    findall(X, ownedPokemon(X), List),
    ifThenElse(nth0(0, List, _), getListOfPokemons(List), warningMessage()),
    menu().

warningMessage() :-
  nl,
  write('Você precisa cadastrar pokemons!!'), nl, nl,
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

moveMenu(player(Name, position(X,Y))) :-
  write('Mover 50 posicoes para onde?'), nl,
  write('1- Para cima'), nl,
  write('2- Para baixo'), nl,
  write('3- Para esquerda'), nl,
  write('4- Para direita'), nl,
  read(Choice),
  movePlayer(Name, position(X,Y), Choice).

movePlayer(Name, position(X,Y), 1) :-
  retract(player(Name, position(X,Y))),
  NewY is Y +50,
  assert( player(Name, position(X, NewY))),
  menu().

movePlayer(Name, position(X,Y), 2) :-
  retract(player(Name, position(X,Y))),
  NewY is Y -50,
  assert( player(Name, position(X, NewY))),
  menu().

movePlayer(Name, position(X,Y), 3) :-
  retract(player(Name, position(X,Y))),
  NewX is X -50,
  assert( player(Name, position(NewX, Y))),
  menu().

movePlayer(Name, position(X,Y), 4) :-
  retract(player(Name, position(X,Y))),
  NewX is X +50,
  assert( player(Name, position(NewX, Y))),
  menu().
