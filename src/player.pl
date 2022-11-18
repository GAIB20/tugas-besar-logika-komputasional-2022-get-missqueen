/* FACTS */
/* isPlayer(P)

   Fakta menunjukan bahwa P adalah pemain. */
isPlayer(pemain1).
isPlayer(pemain2).

/* playerLocation(P, LOC)

   Fakta menunjukan lokasi 
   pemain P, yaitu LOC. */
:- dynamic playerLocation/2.
playerLocation(pemain1, loc_GO).
playerLocation(pemain2, loc_GO).

/* playerCash(P, CASH)

   Fakta menunjukan jumlah 
   dana tunai pemain P, 
   yaitu CASH. */
:- dynamic playerCash/2.
playerCash(pemain1, 0).
playerCash(pemain2, 0).

/* playerPropList(P, PROPLIST)

   Fakta menunjukan list petak 
   properti yang dimiliki pemain P, 
   yaitu PROPLIST. (hanya petak, cth. [A1, D2, E4]) */
:- dynamic playerPropList/2.
playerPropList(pemain1, []).
playerPropList(pemain2, []).

/* playerCardList(P, CARDLIST)

   Fakta menunjukan list kartu 
   yang dimiliki pemain P, 
   yaitu CARDLIST. */
:- dynamic playerCardList/2.
playerCardList(pemain1, []).
playerCardList(pemain2, []).

/* RULES */
/* checkPlayerDetail(P)

   Menampilkan informasi mengenai
   pemain P sesuai spek */
% checkPlayerDetail(P, false) :-
