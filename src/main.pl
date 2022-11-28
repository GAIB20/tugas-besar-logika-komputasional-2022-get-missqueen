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
:- playersTurn(player/1).
playersTurn(w).

startingMessage('Selamat datang ke GetMissQueen!').
endingMessage('Bye bye..').

/* CONFIGURATION */
read_player_name :-
    /* Player Pertama */
    write('Masukkan nama player pertama: '),
    read(X),
    nonvar(X), !,
    assertz(playerName(w, X)), 
    assertz(playerLocation(w, cc01)), nl,
    format('Horeee, Met datang ~w!', [X]), nl,
    write('ID Player kamu adalah W!'), nl, nl,
    /* Player Kedua */
    write('Masukkan nama player kedua: '),
    read(Y),
    nonvar(Y), !,
    assertz(playerName(v, Y)), 
    assertz(playerLocation(v, cc02)), nl,
    format('Wessss, Haloo ~w!', [Y]), nl,
    write('ID Player kamu adalah V!').

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
    nl, 
    write('Peta nya gini nih: '), nl,
    map,
    playerName(CurrentPlayer, Name), nl,
    format('~nSekarang gilirannya ~w. ~n', [Name]).

jalan :-
    throwDice,
    evaluateJalan,
    stateGame.

evaluateJalan :-
    playerLocation(CurrentPlayer, Loc),
    tax(Loc),
    taxMechanism, !.
evaluateJalan :-
    playerLocation(CurrentPlayer, jl),
    jailMechanism, !.
evaluateJalan :-
    playerLocation(CurrentPlayer, Loc),
    chanceCard(Loc),
    chanceCardMechanism, !.
evaluateJalan :-
    playerLocation(CurrentPlayer, Loc),
    property(Loc),
    propertyMechanism, !.

/* Property */
propertyMechanism :-
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
            ) ; write('Oke.')
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
            ) ; write('Okedeh gpp kalo gamau beli.')
        )
    ), 
    retract(playerName(CurrentPlayer, Name)),
    assertz(playerName(CurrentPlayer, Name)),
    !.

/* Jail */
jailMechanism :-
    Loc == jl,
    assertz(jailTimeLeft(CurrentPlayer, 3)), nl,
    write('Yah masuk penjara AOKWOWKWOK'), nl,
    retract(playerName(CurrentPlayer, Name)),
    assertz(playerName(CurrentPlayer, Name)).

/* ChanceCard */
chanceCardMechanism :- 
    write('Widi! Kamu dapet hadiah nih.'), nl,
    playerLocation(CurrentPlayer, Loc),
    landOnChanceCard(CurrentPlayer),
    retract(playerName(CurrentPlayer, Name)),
    assertz(playerName(CurrentPlayer, Name)).

/* WorldTour */

/* Tax */
taxMechanism :-
    write('Waduh! Kamu kena pajak nih.'), nl,
    taxed(CurrentPlayer),
    retract(playerName(CurrentPlayer, Name)),
    assertz(playerName(CurrentPlayer, Name)).

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