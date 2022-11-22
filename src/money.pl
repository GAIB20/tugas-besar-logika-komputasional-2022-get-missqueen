/* FACTS */

/* parkirGratis(P)
   Fakta menunjukkan apakah player memiliki
   kartu parkir Gratis 
   parkirGratis(P) */
:- dynamic parkirGratis/1
parkirGratis(pemain1).
parkirGratis(pemain2).


/* RULES */

/* payPlayer(P1, P2, CASH)
   Rule ketika P1 membayar P2 sebanyak CASH */
payPlayer(P1, P2, CASH) :-
   retract(playerCash(P1, OldCashP1)),
   NewCashP1 is OldCashP1 - CASH,
   assertz(playerCash(P1, NewCashP1)),
   retract(playerCash(P2, OldCashP2)),
   NewCashP2 is OldCashP2 + CASH,
   assertz(playerCash(P2, NewCashP2)).

/* freePark(P)
   Rule jika free park maka tidak membayar properti) */

