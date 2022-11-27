/* 
:- include('bankrupt.pl').
:- include('chancecard.pl').
*/
/*
:- include('dice.pl'). */
/*
:- include('jail.pl').
*/
:- consult('location.pl').
:- consult('map.pl').
/*
:- include('money.pl'). */
:- consult('player.pl'). 
:- consult('property.pl').
/*
:- include('tax.pl').
*/
:- consult('utils.pl').
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
    assertz(playerName(player1, X)), 
    assertz(playerLocation(player1, go)), nl,
    format('Hore. Selamat datang, ~w!', [X]), nl,
    /* Player Kedua */
    write('Masukkan nama player kedua: '),
    read(Y),
    nonvar(Y), !,
    assertz(playerName(player1, Y)), 
    assertz(playerLocation(player1, go)), nl,
    format('Hore. Selamat datang, ~w!', [Y]), nl.

/* PLAY GAME */
startGame :-
    retract(state(false)),
    assertz(state(true)),
    startingMessage(StartMessage),
    write(StartMessage), nl,
    /* Game Confiq */
    read_player_name,
    loopGame. 

/* Case Switch
checkLocationDetail(a1).
checkPropertyDetail(a1).
checkPlayerDetail(x).
throwDice
*/
    
loopGame :-
    map.
    /* Rekursif 
        loopGame. */

help :-
    nl,
    write('Halo! Kesusahan main monopoli? Kami bantu nih'), nl,
    write('Berikut command yang bisa kamu lakukan:'), nl,
    write('1. checkLocationDetail(b)'), tab(6), write('dengan b adalah bangunan'), nl,
    write('2. checkPropertyDetail(p)'), tab(6), write('dengan p adalah properti'), nl,
    write('3. checkPlayerDetail(l)'), tab(8), write('dengan l adalah player'), nl,
    write('4. throwDice'), nl.