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
    X = 'a',
    nonvar(X), !,
    assertz(playerName(w, X)), 
    assertz(playerLocation(w, go)), nl,
    format('Horeee, Met datang ~w!', [X]), nl,
    write('ID Player kamu adalah W!'), nl, nl,
    /* Player Kedua */
    write('Masukkan nama player kedua: '),
    Y = 'b',
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
    isPlayer(PrevPlayer),
    \+ playersTurn(PrevPlayer),
    jailTimeLeft(PrevPlayer, 0),
    \+ justGotOutOfJail(PrevPlayer),
    write('================= INI STATE GAME ================= '), nl,
    playersTurn(CurrentPlayer),
    nl, 
    write('Peta nya gini nih: '), nl,
    map,
    playerName(CurrentPlayer, Name), nl,
    format('~nSekarang gilirannya ~w. ~n', [Name]), !.

stateGame :-
    isPlayer(PrevPlayer),
    \+ playersTurn(PrevPlayer),
    jailTimeLeft(PrevPlayer, JailTime),
    JailTime > 0,
    playersTurn(CurrentPlayer),
    playerName(CurrentPlayer, Name), nl,
    format('~nSekarang gilirannya ~w. ~n', [Name]), !.

stateGame :-
    isPlayer(PrevPlayer),
    \+ playersTurn(PrevPlayer),
    justGotOutOfJail(PrevPlayer),
    retract(justGotOutOfJail(PrevPlayer)),
    playersTurn(CurrentPlayer),
    playerName(CurrentPlayer, Name), nl,
    format('~nSekarang gilirannya ~w. ~n', [Name]), !.


jalan :-
    throwDice,
    evaluateJalan,
    switchPlayer,
    stateGame, !.

jalan(X) :-
    throwDice(X, X),
    evaluateJalan,
    switchPlayer,
    stateGame, !.

jalan(X, Y) :-
    throwDice(X, Y),
    evaluateJalan,
    switchPlayer,
    stateGame, !.

throwDice(Num1, Num2) :-
    playersTurn(CurrentPlayer),
    playerName(CurrentPlayer, Nama),
    playerLocation(CurrentPlayer, Loc),
    jailTimeLeft(CurrentPlayer, JailTime),
    nl,
    retract(diceNum(dice1, _OldNum1)),
    assertz(diceNum(dice1, Num1)),
    format('Dadu 1: ~w ~n', [Num1]),
    retract(diceNum(dice2, _OldNum2)),
    assertz(diceNum(dice2, Num2)),
    format('Dadu 2: ~w ~n', [Num2]),
    diceNum(dice1, DiceFace1),
    diceNum(dice2, DiceFace2),
    Move is DiceFace1+DiceFace2,
    doubleCount(CurrentPlayer, Count), !,
    (
        JailTime > 0 -> (
            (
                (DiceFace1 =:= DiceFace2) -> (
                    write('yee keluar dr penjara'), nl,
                    evaluatePrisonDiceRoll(CurrentPlayer, true)
                );
                (DiceFace1 =\= DiceFace2) -> (
                    evaluatePrisonDiceRoll(CurrentPlayer, false),
                    jailTimeLeft(CurrentPlayer, NewJailTime),
                    write(JailTime),
                    (
                        NewJailTime > 0 -> (
                            write('maaf km msh di penjara...'), nl
                        ); (NewJailTime =:= 0) -> (
                            assertz(justGotOutOfJail(CurrentPlayer)),
                            write('yee keluar dr penjara'), nl
                        )
                    )
                )
            )
        );
        (JailTime =:= 0, DiceFace1 =:= DiceFace2) -> (
                retract(doubleCount(CurrentPlayer, OldCount)),
                NewCount is OldCount+1,
                assertz(doubleCount(CurrentPlayer, NewCount)),
                write('Anjay Double!'), nl
        ); (JailTime =:= 0)
    ),
    (
        JailTime =:= 0 -> (
            doubleCount(CurrentPlayer, CurrentCount),
            (
                CurrentCount < 3 -> (
                    format('Kamu maju sebanyak ~w langkah.', [Move]), nl,
                    moveAfterRoll(CurrentPlayer,Move)
                );
                CurrentCount =:= 3 -> (
                    retract(doubleCount(CurrentPlayer, _)),
                    assertz(doubleCount(CurrentPlayer, 0)),
                    write('FBI OPEN UP! kamu masuk penjara karena kebanyakan double lah pokoknya'), nl,
                    moveTo(CurrentPlayer, jl),
                    retract(jailTimeLeft(CurrentPlayer, _)),
                    assertz(jailTimeLeft(CurrentPlayer, 3))
                )
            )
        ); (JailTime > 0)
    ),
    map,
    !.

evaluateJalan :-
    playersTurn(CurrentPlayer),
    playerLocation(CurrentPlayer, Loc),
    tax(Loc),
    taxMechanism, !.
evaluateJalan :-
    playersTurn(CurrentPlayer),
    playerLocation(CurrentPlayer, jl),
    jailTimeLeft(CurrentPlayer, JailTime),
    JailTime =:= 3,
    jailMechanism, !.
evaluateJalan :-
    playersTurn(CurrentPlayer),
    playerLocation(CurrentPlayer, jl),
    jailTimeLeft(CurrentPlayer, JailTime),
    JailTime =:= 3,
    write('Yah masuk penjara AOKWOWKWOK'), !.
evaluateJalan :-
    playersTurn(CurrentPlayer),
    playerLocation(CurrentPlayer, jl),
    jailTimeLeft(CurrentPlayer, JailTime), JailTime < 3, !.
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
    jailTimeLeft(CurrentPlayer, JailTime), JailTime > 0, nl,
    write('Yah masuk penjara AOKWOWKWOK'), nl.

/* ChanceCard */
chanceCardMechanism :- 
    playersTurn(CurrentPlayer),
    write('Widi! Kamu dapet hadiah nih.'), nl,
    playerLocation(CurrentPlayer, Loc),
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
