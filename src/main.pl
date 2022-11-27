/* 
:- include('bankrupt.pl').
:- include('chancecard.pl').
*/
/*
:- include('dice.pl'). */
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
    assertz(playerName(player1, X)), 
    assertz(playerLocation(player1, go)), nl,
    format('Hore. Selamat datang, ~w!', [X]), nl,
    /* Player Kedua */
    write('Masukkan nama player kedua: '),
    read(Y),
    nonvar(Y), !,
    assertz(playerName(player2, Y)), 
    assertz(playerLocation(player2, go)), nl,
    format('Hore. Selamat datang, ~w!', [Y]), nl.

/* PLAY GAME */

startGame :-
    retract(state(_)),
    assertz(state(true)),
    startingMessage(StartMessage),
    write(StartMessage), nl,
    /* Game Config */
    read_player_name,
    loopGame. 

loopGame :-
    nl, 
    write('Berikut merupakan state peta: '), nl,
    map, nl,
    write('Ketik help jika kamu bingung! '), nl,
    write('Masukkan command: '), nl,
    read(Command).

/* Case Switch
checkLocationDetail(a1).
checkPropertyDetail(a1).
checkPlayerDetail(x).
throwDice
*/

help :-
    nl,
    write('Halo! Kesusahan main monopoli? Kami bantu nih'), nl,
    write('Berikut command yang bisa kamu lakukan:'), nl,
    write('1. checkLocationDetail(b)'), tab(6), write('dengan b adalah bangunan'), nl,
    write('2. checkPropertyDetail(p)'), tab(6), write('dengan p adalah properti'), nl,
    write('3. checkPlayerDetail(l)'), tab(8), write('dengan l adalah player'), nl,
    write('4. throwDice'), nl.