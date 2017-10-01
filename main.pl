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
    write(L),
    nl, nl,
    menu().

option(3) :-
    findall((X,Y), player(X,Y), L),
    nl, write('sua Posição é: '),
    write(L),
    nl, nl,
    menu().

option(4) :-
    findall((X,Y), player(X,Y), L),
    write(L),
    foreach(membro((_,position(X,Y)), L), scanEnemies(X,Y)),
    nl, nl,
    findall(X, ownedPokemon(X), List),
		getListOfPokemons(List),
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
