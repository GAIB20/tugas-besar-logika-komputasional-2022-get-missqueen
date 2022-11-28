/* 
:- include('bankrupt.pl'). */
:- include('chancecard.pl').
:- include('dice.pl').
:- include('jail.pl').
:- include('location.pl').
:- include('map.pl').
/*
:- include('money.pl'). */
:- include('player.pl'). 
:- include('property.pl').
:- include('tax.pl').
:- include('utils.pl').
/*
:- include('worldtour.pl').
*/


/* DEKLARASI FAKTA */
/* Fakta menunjukkan apakah permainan sudah dimulai */
:- dynamic(state/1).
state(false).

/* Players Turn */
:- dynamic(playersTurn/1).
playersTurn(w).

startingMessage('Selamat datang ke GetMissQueen!').
endingMessage('Bye bye..').

/* PLAYER CONFIGURATION */
read_player_name :-
    /* Player Pertama */
    write('Masukkan nama player pertama: '),
    read(X),
    nonvar(X), !,
    assertz(playerName(w, X)), 
    assertz(playerLocation(w, go)), nl,
    format('Horeee, Met datang ~w!', [X]), nl,
    write('ID Player kamu adalah W!'), nl, nl,
    /* Player Kedua */
    write('Masukkan nama player kedua: '),
    read(Y),
    nonvar(Y), !,
    assertz(playerName(v, Y)), 
    assertz(playerLocation(v, go)), nl,
    format('Wessss, Haloo ~w!', [Y]), nl,
    write('ID Player kamu adalah V!').

switchPlayer :-
    playersTurn(w),
    retract(playersTurn(w)),
    asserta(playersTurn(v)).

switchPlayer :-
    playersTurn(v),
    retract(playersTurn(v)),
    asserta(playersTurn(w)).

/* PLAY GAME */
startGame :-
    retract(state(_S)),
    assertz(state(true)),
    startingMessage(StartMessage),
    write(StartMessage), nl,
    /* Game Config */
    read_player_name,
    stateGame, nl,
    write('Kalo ngang-ngong ketik help aja! '), nl,
    write('Mau ngapain? '),
    !.

stateGame :-
    write('================= INI STATE GAME ================= '), nl,
    playersTurn(CurrentPlayer),
    nl, 
    write('Peta nya gini nih: '), nl,
    map,
    playerName(CurrentPlayer, Name), nl,
    format('~nSekarang gilirannya ~w. ~n', [Name]), !.

jalan :-
    throwDice,
    evaluateJalan,
    switchPlayer,
    stateGame, !.

evaluateJalan :-
    playersTurn(CurrentPlayer),
    playerLocation(CurrentPlayer, Loc),
    tax(Loc),
    taxMechanism, !.
evaluateJalan :-
    playersTurn(CurrentPlayer),
    playerLocation(CurrentPlayer, jl),
    jailMechanism, !.
evaluateJalan :-
    playersTurn(CurrentPlayer),
    playerLocation(CurrentPlayer, Loc),
    chanceCard(Loc),
    chanceCardMechanism, !.
evaluateJalan :-
    playersTurn(CurrentPlayer),
    playerLocation(CurrentPlayer, Loc),
    property(Loc),
    propertyMechanism, !.

/* Property */
propertyMechanism :-
    playersTurn(CurrentPlayer),
    playerLocation(CurrentPlayer, Loc),
    playerPropList(CurrentPlayer, X),
    isPropertyOwned(X, Loc, Val),
    (
        Val =:= 1 -> (
            format("Apakah kamu ingin mengupgrade ~w? [y/n]~n", [Loc]),
            read(Command),
            (
                Command == y -> (
                    upgradeProp(CurrentPlayer, Loc), !
                )
            ) ; write('Oke.'), nl
        ) ; nl
    ),
    (
        Val =:= 0 -> (
            /* Kalau propertinya dimiliki orang */

            /* Kalau propertinya ga dimilikin siapa siapa */
            format("Apakah kamu ingin membeli ~w? [y/n]~n", [Loc]),
            read(Command),
            (
                Command == y -> (
                    buyProperty(CurrentPlayer, Loc), !
                )
            ) ; write('Okedeh gpp kalo gamau beli.'), nl
        )
    ), 
    retract(playerName(CurrentPlayer, Name)),
    assertz(playerName(CurrentPlayer, Name)),
    !.

/* Jail */
jailMechanism :-
    playersTurn(CurrentPlayer),
    assertz(jailTimeLeft(CurrentPlayer, 3)), nl,
    write('Yah masuk penjara AOKWOWKWOK'), nl,
    retract(playerName(CurrentPlayer, Name)),
    assertz(playerName(CurrentPlayer, Name)), !.

/* ChanceCard */
chanceCardMechanism :- 
    playersTurn(CurrentPlayer),
    write('Widih dapet sembako.'), nl,
    landOnChanceCard(CurrentPlayer),
    retract(playerName(CurrentPlayer, Name)),
    assertz(playerName(CurrentPlayer, Name)), !.

/* WorldTour */

/* Tax */
taxMechanism :-
    playersTurn(CurrentPlayer),
    write('Waduh! Kamu kena pajak nih.'), nl,
    taxed(CurrentPlayer),
    retract(playerName(CurrentPlayer, Name)),
    assertz(playerName(CurrentPlayer, Name)), !.

/* FreeParking */

/* Commands:
checkLocationDetail(a1).
checkPropertyDetail(a1).
checkPlayerDetail(x).
throwDice atau jalan
*/

help :-
    nl,
    write('Eh jangan nangis dong. Kalo bengong dibantuin nih,'), nl,
    write('Gini katalognya:'), nl,
    write('1. checkLocationDetail(b)'), tab(6), write('dengan b adalah bangunan'), nl,
    write('2. checkPropertyDetail(p)'), tab(6), write('dengan p adalah properti'), nl,
    write('3. checkPlayerDetail(l)'), tab(8), write('dengan l adalah player'), nl,
    write('4. jalan'), nl.