/* 
:- include('bankrupt.pl').
:- include('chancecard.pl').
*/
:- include('dice.pl').
/*
:- include('jail.pl').
*/
:- include('location.pl').
:- include('map.pl').
/*
:- include('money.pl'). */
:- include('player.pl'). 
:- include('property.pl').
/*
:- include('tax.pl').
*/
:- include('utils.pl').
/*
:- include('worldtour.pl').
*/

/* DEKLARASI FAKTA */
/* Fakta menunjukkan apakah permainan sudah dimulai */
:- dynamic(state/1).
state(false).

startingMessage('Selamat datang ke GetMissQueen!').
endingMessage('Bye bye..').


/* CONFIGURATION */
read_player_name :-
    /* Player Pertama */
    write('Masukkan nama player pertama: '),
    read(X),
    nonvar(X), !,
    assertz(playerName(w, X)), 
    assertz(playerLocation(w, go)), nl,
    format('Horeee, Met datang ~w!', [X]), nl,
    write('ID Player kamu adalah W!'), nl,
    /* Player Kedua */
    write('Masukkan nama player kedua: '),
    read(Y),
    nonvar(Y), !,
    assertz(playerName(v, Y)), 
    assertz(playerLocation(v, go)), nl,
    format('Wessss, Haloo ~w!', [Y]), nl,
    write('ID Player kamu adalah V!').

/* PLAY GAME */

startGame :-
    retract(state(_)),
    assertz(state(true)),
    startingMessage(StartMessage),
    write(StartMessage), nl,
    /* Game Config */
    read_player_name,
    stateGame. 

stateGame :-
    nl, 
    write('Peta nya gini nih: '), nl,
    map, nl,
    write('Kalo ngang-ngong ketik help aja! '), nl,
    write('Mau ngapain? ').

jalan :-
    throwDice,
    stateGame.

/* Commands:
checkLocationDetail(a1).
checkPropertyDetail(a1).
checkPlayerDetail(x).
throwDice atau jalan
*/

help :-
    nl,
    write('Eh jangan nangis dong. Kalo bengong dibantuin nih'), nl,
    write('Gini katalognya, baik kan admin?'), nl,
    write('1. checkLocationDetail(b)'), tab(6), write('dengan b adalah bangunan'), nl,
    write('2. checkPropertyDetail(p)'), tab(6), write('dengan p adalah properti'), nl,
    write('3. checkPlayerDetail(l)'), tab(8), write('dengan l adalah player'), nl,
    write('4. jalan'), nl.