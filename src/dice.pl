/* FACTS */
/* Angka Dadu */
:- dynamic(diceNum/2).
diceNum(dice1, 0).
diceNum(dice2, 0).

/* Double Count */
:- dynamic(doubleCount/2).
doubleCount(pemain1, 0).
doubleCount(pemain2, 0).

/* RULES */
/* Menghasilkan angka 1-6 */
generateDiceNum(Num) :-
    random(1, 7, DiceFace),
    Num is DiceFace.

throwDice :-
    playerName(Player, Name),
    format('Sekarang adalah giliran ~s ~n.', [Name]),
    nl,
    generateDiceNum(Num),
    assertz(diceNum(dice1, Num)),
    format('Dadu 1: ~w ~n', [Num]),
    generateDiceNum(Num),
    assertz(diceNum(dice1, Num)),
    format('Dadu 2: ~w ~n', [Num]),
    diceNum(dice1, DiceFace1),
    diceNum(dice2, DiceFace2),
    doubleCount(Player, Count),
    (
        DiceFace1 =:= DiceFace2 ->
        (assertz(doubleCount(Player, (Count+1))),
        format('Double! ~n'))
        ; nl
    ),
    doubleCount(Player, Count),
    (
        Count =:= 3 -> (
            assertz(doubleCount(Player, 0)),
            goToJail(Player),
            format('Wah! Anda masuk penjara karena mendapatkan double 3 kali berturut-turut :( ~n'))
        ; format('Anda maju sebanyak ~w langkah. ~n')
    ),
    !.