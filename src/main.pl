:- consult('bankrupt.pl').
:- consult('chancecard.pl').
:- consult('dice.pl').
:- consult('jail.pl').
:- consult('location.pl').
:- consult('map.pl').
:- consult('money.pl').
:- consult('player.pl').
:- consult('property.pl').
:- consult('tax.pl').
:- consult('utils.pl').
:- consult('worldtour.pl').

/* DEKLARASI FAKTA */
/* Fakta menunjukkan apakah permainan sudah dimulai */
:- dynamic(state/1).
state(false).

startingMessage('Selamat datang ke GetMissQueen!').
endingMessage('Bye bye..').

/* KONFIGURASI */
read_player_name(X,Y):-
    format('Masukkan nama player pertama: '),
    read(X),
    assertz(playerName(player1, X)), nl,
    format('Hore. Selamat datang, ~w!', [X]), nl,
    format('Masukkan nama player kedua: '),
    read(Y),
    assertz(playerName(player1, Y)), nl,
    format('Hore. Selamat datang, ~w!', [Y]), nl.

/* DEKLARASI RULE */
startGame :-
    /* STARTING MESSAGE */
    retract(state(false)),
    assertz(state(true)),
    startingMessage(StartMessage),
    write(StartMessage), nl,
    read_player_name(X,Y).