/* Minigame Coin Flip */
/* FACTS */
coin(0, 'h').
coin(1, 't').

:- dynamic(coinFace/1).
coinFace(0).

:- dynamic(correctGuesses/1).
correctGuesses(0).

/* RULES */
flipCoin(CoinNum) :-
    random(0, 2, Num),
    CoinNum is Num.

coinFlip(Player) :-
    flipCoin(CoinNum),
    retract(coinFace(_OldCoinFace)),
    assertz(coinFace(CoinNum)),
    coin(CoinNum, Face),
    format('*Flips coin* ~n ~n Tebak hayoo, heads or tails? (h/t) ', []),
    nl,
    write('| ?- '),
    read(Input),
    nl,
    (
        (Input == Face) -> (
            retract(correctGuesses(OldGuessCount)),
            NewGuessCount is OldGuessCount+1,
            assertz(correctGuesses(NewGuessCount)),
            (
                (NewGuessCount == 1) -> (
                    write('Wuidihh bener. Lagi lagi,'),
                    nl, nl,
                    coinFlip(Player)
                ) ; (NewGuessCount == 2) -> (
                    write('Wuissss bener lagi, terakhir yok,'),
                    nl, nl,
                    coinFlip(Player)
                ) ; (NewGuessCount == 3) -> (
                    write('Hoki parahhh, udah udah.. nanti admin nya kere.'),
                    nl, nl,
                    retract(playerCash(Player, OldCash)),
                    NewCash is OldCash + 5000,
                    assertz(playerCash(Player, NewCash)),
                    format('Kamu dapet Grand Prize 5000 cash dari mini game coin flip. Coba deh cari pacar siapa tau hoki juga... ~n', []),
                    retract(correctGuesses(_)),
                    assertz(correctGuesses(0))
                )
            )
        ) ; (
            format('Salah HAHAHAH ~n', []),
            retract(playerCash(Player, OldCash)),
            correctGuesses(GuessCount),
            Reward is GuessCount * 1000,
            NewCash is OldCash + (Reward),
            assertz(playerCash(Player, NewCash)),
            format('Kamu dapet ~w cash dari mini game coin flip. Ciao! ~n', [Reward]),
            retract(correctGuesses(_)),
            assertz(correctGuesses(0))
        )
    ).
