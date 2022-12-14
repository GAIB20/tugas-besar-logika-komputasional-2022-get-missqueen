/* FACTS */
/* jailTimeLeft(P, TIME)

   Fakta menunjukan sisa waktu seorang
   pemain perlu menunggu di penjara.
   Fakta hanya berlaku jika pemain P sedang
   dipenjara. */
:- dynamic(jailTimeLeft/2).
jailTimeLeft(w,0).
jailTimeLeft(v,0).

:- dynamic(justGotOutOfJail/1).

bailPrice(5000).

/* RULES */
/* evaluatePrisonDiceRoll(P, DOUBLE)

   Melakukan evaluasi terhadap hasil
   lemparan dadu. Jika melempar Double
   fakta jailTimeLeft pemain P di retract,
   jika tidak double  */
evaluatePrisonDiceRoll(P, false) :- 
                                   retract(jailTimeLeft(P, OldVal)),
                                   NewVal is OldVal - 1, !,
                                   NewVal >= 0,
                                   assertz(jailTimeLeft(P, NewVal)).
evaluatePrisonDiceRoll(P, true) :-
                                  retract(jailTimeLeft(P, _OldVal)),
                                  assertz(jailTimeLeft(P, 0)).

/* Mengevaluasi apakah pemain bisa
   membayar untuk keluar penjara */
canPayBail(P) :-
                bailPrice(Min),
                playerCash(P, Cash),
                Cash >= Min.

/* Pemain membayar sebanyak XX
   untuk keluar dari penjara 
   (fakta jailTimeLeft di-retract).
   Asumsi dana sudah cukup, evaluasi
   sebelum pemanggilan fungsi. */
payBail(P) :-
             bailPrice(Price),
             retract(playerCash(P, OldCash)),
             NewCash is OldCash - Price,
             assertz(playerCash(P, NewCash)),
             retract(jailTimeLeft(P, _OldTime)),
             assertz(jailTimeLeft(P, 0)).

/* Mengevaluasi apakah pemain memliki,
   kartu Get Out of Jail */
hasGOoJCard(P) :-
                 playerCardList(P, L),
                 getIndex(L, getOutOfJailCard, _Index), !.

/* Pemain menggunakan kartu get out of
   jail untuk keluar dari penjara 
   (fakta jailTimeLeft di-retract).
   Asumsi dana sudah cukup, evaluasi
   sebelum pemanggilan fungsi. */
useGOoJCard(P) :-
                 retract(playerCardList(P, OldList)),
                 deleteVal(OldList, getOutOfJailCard, NewList),
                 assertz(playerCash(P, NewList)),
                 retract(jailTimeLeft(P, _OldTime)),
                 assertz(jailTimeLeft(P, 0)).
