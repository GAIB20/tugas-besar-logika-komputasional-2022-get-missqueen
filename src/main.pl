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
:- include('worldtour.pl').
:- include('coinflip.pl').


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
    assertz(playerLocation(w, go)), 
    assertz(playerCash(w, 5000)), nl,
    format('Horeee, Met datang ~w!', [X]), nl,
    write('ID Player kamu adalah W.'), nl, nl,
    /* Player Kedua */
    write('Masukkan nama player kedua: '),
    read(Y),
    nonvar(Y), !,
    assertz(playerName(v, Y)), 
    assertz(playerLocation(v, go)), 
    assertz(playerCash(v, 5000)), nl,
    format('Wessss, Haloo ~w!', [Y]), nl,
    write('ID Player kamu adalah V.').

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
    (
        state(false) ->(
            retract(state(_S)),
            assertz(state(true)),
            startingMessage(StartMessage),
            write(StartMessage), nl,
            /* Game Config */
            read_player_name,
            stateGame, nl,
            write('Kalo ngang-ngong ketik help aja! '), nl,
            write('Mau ngapain? '),
            !    
        ) ; write('maaf permainan sudah dimulai')
    ), !.


stateGame :-
    write(' '), nl,
    playersTurn(CurrentPlayer),
    nl, 
    write('Peta nya gini nih: '), nl,
    map,
    playerName(CurrentPlayer, Name), nl,
    format('Sekarang gilirannya ~w. ~n', [Name]), !.

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
evaluateJalan :-
    playersTurn(CurrentPlayer),
    playerLocation(CurrentPlayer, cf),
    coinflipMechanism, !.
evaluateJalan :-
    playersTurn(CurrentPlayer),
    playerLocation(CurrentPlayer, fp),
    freeParkMechanism, !.

/* Property */
propertyMechanism :-
    playersTurn(CurrentPlayer),
    playerLocation(CurrentPlayer, Loc),
    playerPropList(CurrentPlayer, X),
    isPropertyOwned(X, Loc, Val),
    (
        Val =:= 1 -> (
            format("Apakah kamu ingin upgrade ~w? [y/n]~n", [Loc]),
            write('| ?- '),
            read(Command),
            nl,
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
            write('| ?- '),
            read(Command),
            nl,
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
    write('Yah masuk penjara AOKWOWKWOK'), nl, !.

/* ChanceCard */
chanceCardMechanism :- 
    playersTurn(CurrentPlayer),
    write('Widih dapet sembako.'), nl,
    landOnChanceCard(CurrentPlayer),
    retract(playerName(CurrentPlayer, Name)),
    assertz(playerName(CurrentPlayer, Name)), !.

/* WorldTour */
wtMechanism :-
    playersTurn(CurrentPlayer),
    playerLocation(CurrentPlayer, Loc),
    write('Selamat! Kamu sekarang bisa World Tour!!'), nl,
    write('Masukkan tujuan yang kamu mau: '), 
    read(WTLoc),
    allLocationList(AllLoc),
    validateInput(AllLoc, WTLoc),
    (
        Loc == WTLoc -> (
            write('Woi yang bener woi masa mau diem doang di sini'), nl,
            write('Coba lagi deh, mau kemana?'),
            read(WTLoc), 
            validateInput(AllLoc, WTLoc)
        ) ; nl
    ),
    (
        Loc == wt -> (
            write('Gaboleh curang ah kok mau World Tour lagi'), nl,
            write('Coba lagi deh, mau kemana?'),
            read(WTLoc), 
            validateInput(AllLoc, WTLoc)
        ) ; nl
    ),
    evaluateWorldTour(CurrentPlayer, WTLoc, Loc).

/* Tax */
taxMechanism :-
    playersTurn(CurrentPlayer),
    write('Waduh! Kamu kena pajak nih.'), nl,
    taxed(CurrentPlayer), !.

/* FreeParking */
freeParkMechanism :-
    write('Aeh aeh parkir gratis terus kayak di kubus'), nl,
    write('Gaada apa-apa disini, lanjut gih.').

/* Coin Flip */
coinflipMechanism :-
    playersTurn(CurrentPlayer),
    coinFlip(CurrentPlayer), !.

/* Commands:
checkLocationDetail(a1).
checkPropertyDetail(a1).
checkPlayerDetail(x).
throwDice atau jalan
*/

help :-
    nl,
    write('Eh jangan nangis dong. Kalo bengong dibantuin nih,'), nl,
    write('Gini katalognya:'), nl, nl,
    write('1. checkLocationDetail(b)    :   Cek detail lokasi bangunan \'b\'.'), nl,
    write('2. checkPropertyDetail(p)    :   Cek detail properti \'p\'.'), nl,
    write('3. checkPlayerDetail(l)      :   Cek detail untuk ID pemain \'l\''), nl,
    write('4. jalan                     :   Roll dice untuk maju pada peta.'), nl,
    write('5. stateGame                 :   Melihat state dari permainan.'), nl,
    write('6. help                      :   The best Indian call center.'), nl.