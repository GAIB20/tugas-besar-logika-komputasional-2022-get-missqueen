/* FACTS */
/* Angka Dadu */
:- dynamic(diceNum/2).
diceNum(dice1, 0).
diceNum(dice2, 0).

/* Double Count */
:- dynamic(doubleCount/2).
doubleCount(w, 2).
doubleCount(v, 0).

/* Double Run */
:- dynamic(doubleRun/1).
doubleRun(false).


/* RULES */
/* Menghasilkan angka 1-6 */
generateDiceNum(Num) :-
    random(1, 7, DiceFace),
    Num is DiceFace.

throwDice :-
    playersTurn(CurrentPlayer),
    playerLocation(CurrentPlayer, Loc),
    jailTimeLeft(CurrentPlayer, JailTime),
    nl,
    generateDiceNum(Num1),
    retract(diceNum(dice1, _OldNum1)),
    assertz(diceNum(dice1, Num1)),
    format('Dadu 1: ~w ~n', [Num1]),
    nl,
    generateDiceNum(Num2),
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
