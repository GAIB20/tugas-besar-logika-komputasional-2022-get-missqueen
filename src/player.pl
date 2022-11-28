 /* FACTS */
/* isPlayer(P)

   Fakta menunjukan bahwa P adalah player. */
isPlayer(w).
isPlayer(v).

/* playerName(P)

   Fakta menunjukan bahwa P adalah player. */
:- dynamic(playerName/2).
   /*
   DUMMY FACT
   playerName(w, "Anton").
   playerName(v, "Budi"). */

/* playerLocation(P, LOC)

   Fakta menunjukan lokasi 
   player P, yaitu LOC. */
:- dynamic(playerLocation/2).
   /*
   DUMMY FACT
   playerLocation(w, go).
   playerLocation(v, go). */

/* playerCash(P, CASH)

   Fakta menunjukan jumlah 
   dana tunai player P, 
   yaitu CASH. */
:- dynamic(playerCash/2).
/* playerCash(w, 1000000).
playerCash(v, 1000000). */

/* playerPrpList(P, PROPLIST)

   Fakta menunjukan list petak 
   properti yang dimiliki player P, 
   yaitu PROPLIST. (hanya petak, cth. [A1, D2, E4]) */
:- dynamic(playerPropList/2).
playerPropList(w, []).
playerPropList(v, []).

/* playerCardList(P, CARDLIST)

   Fakta menunjukan list kartu 
   yang dimiliki player P, 
   yaitu CARDLIST. */
:- dynamic(playerCardList/2).
playerCardList(w, []).
playerCardList(v, []).

/* translatePropLevel(Level, TRANSLATED)

   Fakta menunjukan translasi
   dari Level menjadi sebuah string, */
translatePropLevel(0, 'Tanah').
translatePropLevel(1, 'Bangunan 1').
translatePropLevel(2, 'Bangunan 2').
translatePropLevel(3, 'Bangunan 3').
translatePropLevel(4, 'Landmark').

/* translateCardName(Level, TRANSLATED)

   Fakta menunjukan translasi
   dari Card menjadi sebuah string, */
translateCardName(getOutOfJailCard, 'Get Out of Jail Card').
translateCardName(angelCard, 'Angel Card').

/* RULES */
/* totalPropVal(ListProp, TOTAL)

   Mengembalikan total nilai properti
   dari properti pada ListProp */
totalPropVal([], 0).
totalPropVal([Loc|B], TOTAL) :-
                            totalPropVal(B, TOTAL1),
                            levelProp(Loc, Level),
                            cost(Cost, Loc, Level),
                            TOTAL is Cost + TOTAL1.

/* Count List Length */
/* Basis */
countLength([], 0).
/* Rekurens */
countLength([_|TAIL], C) :-
    countLength(TAIL, M),
    C is 1+M.

/* displayPlayersProps(ListProp, Index)

   Menampilkan properti yang dimiliki dengan
   nomor barisan mulai dari Index */
displayPlayersProps([], _Index).
displayPlayersProps([Prop|B], Index) :-
                                       propertyName(PropName, Prop),
                                       levelProp(Prop, Level),
                                       translatePropLevel(Level, LevelTranslated),
                                       cost(Cost, Prop, Level),
                                       format('~w. ~w - ~w - ~w ~n', [Index, PropName, LevelTranslated, Cost]),
                                       Index1 is Index + 1,
                                       displayPlayersProps(B, Index1).

/* displayPlayersCards(ListCard, Index)

   Menampilkan kartu yang dimiliki dengan
   nomor barisan mulai dari Index */
displayPlayersCards([], _Index).
displayPlayersCards([Card|B], Index) :-
                                       translateCardName(Card, CardTranslated),
                                       format('~w. ~w ~n', [Index, CardTranslated]),
                                       Index1 is Index + 1,
                                       displayPlayersCards(B, Index1).

/* Mendapatkan variabel other player 
   Mendapatkan other Player */
otherPlayer(P) :-
   playersTurn(CurrentPlayer),
   isPlayer(P),
   P \== CurrentPlayer.

/* checkPlayerDetail(P)

   Menampilkan informasi mengenai
   player P sesuai spek */
checkPlayerDetail(P) :-
                       playerName(P, Name),
                       playerLocation(P, Loc),
                       playerCash(P, Cash),
                       playerPropList(P, Props),
                       playerCardList(P, Cards),
                       totalPropVal(Props, TotalPropVal),
                       TotalAsset is (Cash+TotalPropVal),
                       nl,
                       format('Informasi ~w ~n', [Name]),
                       nl,
                       format('Lokasi                       : ~w ~n', [Loc]),
                       format('Total Uang                   : ~w ~n', [Cash]),
                       format('Total Nilai Properti         : ~w ~n', [TotalPropVal]),
                       format('Total Aset                   : ~w ~n', [TotalAsset]),
                       nl,
                       countLength(Props, LengthProp),
                       countLength(Cards, LengthCards),
                       write('Punya Properti apa aja       :'),
                       nl,
                       (
                           (LengthProp > 0) -> (
                              displayPlayersProps(Props, 1)
                           ) ; write('Ga punya properti'), nl
                       ),
                       nl,
                       write('Daftar Kepemilikan Kartu     :'),
                       nl,
                       (
                           (LengthCards > 0) -> (
                              displayPlayersCards(Cards, 1)
                           ) ; write('Ga punya kartu'), nl
                       ),
                       nl, !.
checkPlayerDetail(P) :-
                       \+ isPlayer(P),
                       nl, format('~w bukan player itu.. inget inputnya pake ID player yaww. ~n', [P]).