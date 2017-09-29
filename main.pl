:- dynamic player/2.
:- [aux].
:- [pokemons].

ownedPokemon([]) :-
  fail.  % Usuário começa com uma lista vazia de pokemons

play() :-
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


tipo_de_ataque(pikachu, raio). %exemplo
