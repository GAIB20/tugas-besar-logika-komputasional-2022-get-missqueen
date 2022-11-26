 /* FACTS */
/* isPlayer(P)

   Fakta menunjukan bahwa P adalah player. */
isPlayer(player1).
isPlayer(player2).

/* playerName(P)

   Fakta menunjukan bahwa P adalah player. */
:- dynamic(playerName/2).
playerName(player1, "Anton").
playerName(player2, "Budi").


/* playerLocation(P, LOC)

   Fakta menunjukan lokasi 
   player P, yaitu LOC. */
:- dynamic(playerLocation/2).
playerLocation(player1, go).
playerLocation(player2, go).

/* playerCash(P, CASH)

   Fakta menunjukan jumlah 
   dana tunai player P, 
   yaitu CASH. */
:- dynamic(playerCash/2).
playerCash(player1, 0).
playerCash(player2, 0).

/* playerPropList(P, PROPLIST)

   Fakta menunjukan list petak 
   properti yang dimiliki player P, 
   yaitu PROPLIST. (hanya petak, cth. [A1, D2, E4]) */
:- dynamic(playerPropList/2).
playerPropList(player1, []).
playerPropList(player2, []).

/* playerCardList(P, CARDLIST)

   Fakta menunjukan list kartu 
   yang dimiliki player P, 
   yaitu CARDLIST. */
:- dynamic(playerCardList/2).
playerCardList(player1, []).
playerCardList(player2, []).

/* translatePropLevel(Level, TRANSLATED)

   Fakta menunjukan translasi
   dari Level menjadi sebuah string, */
translatePropLevel(0, "Tanah").
translatePropLevel(1, "Bangunan 1").
translatePropLevel(2, "Bangunan 2").
translatePropLevel(3, "Bangunan 3").
translatePropLevel(4, "Landmark").

/* translateCardName(Level, TRANSLATED)

   Fakta menunjukan translasi
   dari Card menjadi sebuah string, */
translateCardName(getOutOfJailCard, "Get Out of Jail Card").

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

/* displayPlayersProps(ListProp, Index)

   Menampilkan properti yang dimiliki dengan
   nomor barisan mulai dari Index */
displayPlayersProps([], Index) :-
                                       format('Tidak ada properti yang dimiliki. ~n', []).
displayPlayersProps([Prop|B], Index) :-
                                       propertyName(PropName, Prop),
                                       levelProp(Prop, Level),
                                       translatePropLevel(Level, LevelTranslated),
                                       format('~w. ~s - ~s ~n', [Index, PropName, LevelTranslated]),
                                       Index1 is Index + 1,
                                       displayPlayersProps(B, Index1).

/* displayPlayersCards(ListCard, Index)

   Menampilkan kartu yang dimiliki dengan
   nomor barisan mulai dari Index */
displayPlayersCards([], Index) :-
                                       format("Tidak ada kartu yang dimiliki. ~n", []).
displayPlayersCards([Card|B], Index) :-
                                       translateCardName(Card, CardTranslated),
                                       format('~s. ~s ~n', [Index, CardTranslated]),
                                       Index1 is Index + 1,
                                       displayPlayersCards(B, Index1).


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
                       format('Informasi Player ~s ~n', [Name]),
                       nl,
                       format('Lokasi                       : ~w ~n', [Loc]),
                       format('Total Uang                   : ~w ~n', [Cash]),
                       format('Total Nilai Properti         : ~w ~n', [TotalPropVal]),
                       format('Total Aset                   : ~w ~n', [TotalAsset]),
                       nl,
                       format('Daftar Kepemilikan Properti  : ~n', []),
                       displayPlayersProps(Props, 1),
                       nl,
                       format('Daftar Kepemilikan Card      : ~n', []),
                       displayPlayersCards(Cards, 1).
