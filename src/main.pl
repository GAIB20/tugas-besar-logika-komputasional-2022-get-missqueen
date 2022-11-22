/* # :- include('bankrupt.pl').
# :- include('chancecard.pl').
# :- include('dice.pl').
# :- include('jail.pl').
# :- include('location.pl').
# :- include('map.pl').
# :- include('money.pl').
# :- include('player.pl').
# :- include('property.pl').
# :- include('tax.pl').
# :- include('utils.pl').
# :- include('worldtour.pl'). */

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
    assertz(playerName(pemain1, X)), nl,
    format('Hore. Selamat datang, ~w!', [X]), nl,
    format('Masukkan nama player kedua: '),
    read(Y),
    assertz(playerName(pemain1, Y)), nl,
    format('Hore. Selamat datang, ~w!', [Y]), nl.

/* DEKLARASI RULE */
startGame :-
    /* STARTING MESSAGE */
    retract(state(false)),
    assertz(state(true)),
    startingMessage(StartMessage),
    write(StartMessage), nl,
    read_player_name(X,Y).