/* FACTS */
/* Angka Dadu */
:- dynamic(diceNum/2).
diceNum(dice1, 0).
diceNum(dice2, 0).

/* Double Count */
:- dynamic(doubleCount/2).
doubleCount(w, 0).
doubleCount(v, 0).

/* Player's Turn*/
:- dynamic(playersTurn/1).
playersTurn(w).

/* RULES */
/* Menghasilkan angka 1-6 */
generateDiceNum(Num) :-
    random(1, 7, DiceFace),
    Num is DiceFace.

throwDice :-
    playersTurn(CurrentPlayer),
    nl,
    generateDiceNum(Num1),
    retract(diceNum(dice1, _OldNum1)),
    assertz(diceNum(dice1, Num1)),
    format('Dadu 1: ~w ~n', [Num1]),
    generateDiceNum(Num2),
    retract(diceNum(dice2, _OldNum2)),
    assertz(diceNum(dice2, Num2)),
    format('Dadu 2: ~w ~n', [Num2]),
    diceNum(dice1, DiceFace1),
    diceNum(dice2, DiceFace2),
    Move is DiceFace1+DiceFace2,
    (
        DiceFace1 =:= DiceFace2 -> (
            retract(doubleCount(CurrentPlayer, OldCount)),
            NewCount is OldCount+1,
            assertz(doubleCount(CurrentPlayer, NewCount)),
            write('Anjay Double!'), nl,
            (
                Loc == jl -> (
                    write('yee keluar dr penjara'), nl,
                    evaluatePrisonDiceRoll(CurrentPlayer, true) 
                )
            ); nl
        ); nl
    ),
    doubleCount(CurrentPlayer, Count),
    (
        Count =:= 3 -> (
            retract(doubleCount(CurrentPlayer, OldCount)),
            assertz(doubleCount(CurrentPlayer, 0)),
            write('FBI OPEN UP! kamu masuk penjara karena kebanyakan double lah pokoknya'), nl
        ); nl
    ),
    (
        Loc == jl -> (
            write('maaf km msh di penjara...'), nl,
            evaluatePrisonDiceRoll(CurrentPlayer, false)
        ); format('Kamu maju sebanyak ~w langkah.', [Move]), nl, moveAfterRoll(CurrentPlayer,Move)
    ),
    retract(playerName(CurrentPlayer, Name)),
    retract(playersTurn(_)),
    assertz(playersTurn(_NextPlayer)),
    assertz(playerName(CurrentPlayer, Name)),
    !.