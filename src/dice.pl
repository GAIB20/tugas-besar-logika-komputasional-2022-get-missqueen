/* FACTS */
/* Angka Dadu */
:- dynamic(diceNum/2).
diceNum(dice1, 0).
diceNum(dice2, 0).

/* Double Count */
:- dynamic(doubleCount/2).
doubleCount(player1, 0).
doubleCount(player2, 0).

/* RULES */
/* Menghasilkan angka 1-6 */
generateDiceNum(Num) :-
    random(1, 7, DiceFace),
    Num is DiceFace.

throwDice :-
    playerName(CurrentPlayer, Name),
    format('Sekarang adalah giliran ~s. ~n', [Name]),
    nl,
    generateDiceNum(Num),
    retract(diceNum(dice1, OldNum1)),
    assertz(diceNum(dice1, Num)),
    format('Dadu 1: ~w ~n', [Num]),
    generateDiceNum(Num),
    retract(diceNum(dice2, OldNum2)),
    assertz(diceNum(dice2, Num)),
    format('Dadu 2: ~w ~n', [Num]),
    diceNum(dice1, DiceFace1),
    diceNum(dice2, DiceFace2),
    Move is DiceFace1+DiceFace2,
    (
        DiceFace1 =:= DiceFace2 -> (
            retract(doubleCount(CurrentPlayer, OldCount)),
            NewCount is OldCount+1,
            assertz(doubleCount(CurrentPlayer, NewCount)),
            write('Double!'), nl)
        ; nl
    ),
    doubleCount(CurrentPlayer, Count),
    (
        Count =:= 3 -> (
            retract(doubleCount(CurrentPlayer, OldCount)),
            assertz(doubleCount(CurrentPlayer, 0)),
            goToJail(CurrentPlayer),
            write('Wah! Anda masuk penjara karena mendapatkan double 3 kali berturut-turut :('), nl)
        ; format('Anda maju sebanyak ~w langkah.', [Move]), nl
    ),
    !.