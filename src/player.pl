/* FACTS */
/* isPlayer(P)

   Fakta menunjukan bahwa P adalah pemain. */
isPlayer(pemain1).
isPlayer(pemain2).

/* playerName(P)

   Fakta menunjukan bahwa P adalah pemain. */
:- dynamic playerName/2.
playerName(pemain1, 'Anton').
playerName(pemain2, 'Budi').


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

/* RULES */
/* locationCostByLevel(Loc, Level, COST)

   Mengembalikan total nilai properti
   dari pada Loc dengan level properti Level */
locationCostByLevel(Loc, 0, COST) :-
                                    costLand(COST, Loc).
locationCostByLevel(Loc, 1, COST) :-
                                    costClassOne(COST, Loc).
locationCostByLevel(Loc, 2, COST) :-
                                    costClassTwo(COST, Loc).
locationCostByLevel(Loc, 3, COST) :-
                                    costClassThree(COST, Loc).
locationCostByLevel(Loc, 4, COST) :-
                                    costLandmark(COST, Loc).

/* totalPropVal(ListProp, TOTAL)

   Mengembalikan total nilai properti
   dari properti pada ListProp */
totalPropVal([], 0).
totalPropVal([Loc|B], TOTAL) :-
                            totalPropVal(B, TOTAL1),
                            levelProp(Loc, Level),
                            locationCostByLevel(Loc, Level, Cost),
                            TOTAL is Cost + TOTAL1.

/* displayPlayersProps(ListProp, Index)

   Menampilkan properti yang dimiliki dengan
   nomor barisan mulai dari Index */
displayPlayersProps([], Index).
displayPlayersProps([Prop|B], Index) :-
                                       propertyName(PropName, Prop),
                                       levelProp(Prop, Level),
                                       translatePropLevel(Level, LevelTranslated),
                                       format('~s. ~s - ~s ~n', [Index, PropName, LevelTranslated]),
                                       Index1 is Index + 1,
                                       displayPlayersProps(B, Index1).

/* displayPlayersCards(ListCard, Index)

   Menampilkan kartu yang dimiliki dengan
   nomor barisan mulai dari Index */
displayPlayersCards([], Index).
displayPlayersCards([Card|B], Index) :-
                                       translateCardName(Card, CardTranslated),
                                       format('~s. ~s ~n', [Index, CardTranslated]),
                                       Index1 is Index + 1,
                                       displayPlayersCards(B, Index1).

/* checkPlayerDetail(P)

   Menampilkan informasi mengenai
   pemain P sesuai spek */
checkPlayerDetail(P) :-
                       playerName(P, Name),
                       playerLocation(P, Loc),
                       playerCash(P, Cash),
                       playerPropList(P, Props),
                       playerCardList(P, Cards),
                       totalPropVal(Props, TotalPropVal),
                       format('Informasi Player ~s ~n', [Name]),
                       nl,
                       format('Lokasi                       : ~s ~n', [Loc]),
                       format('Total Uang                   : ~s ~n', [Cash]),
                       format('Total Nilai Properti         : ~s ~n', [TotalPropVal]),
                       format('Total Aset                   : ~s ~n', [Cash + TotalPropVal]),
                       nl,
                       format('Daftar Kepemilikan Properti  : ~n'),
                       displayPlayersProps(Props, 1),
                       nl,
                       format('Daftar Kepemilikan Card      : ~n'),
                       displayPlayersCards(Cards, 1).
