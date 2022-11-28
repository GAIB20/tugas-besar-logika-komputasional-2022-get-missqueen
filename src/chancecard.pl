/* RULES */
/* Memanggil fungsi random untuk menentukan
   kartu yang ingin diberikan */
landOnChanceCard(P) :-
                      random(1,4, Chance),
                      nl,
                      giveChanceCard(P, 3).

chanceCardReward(1000).

/* Memanggil fungsi chance card yang sesuai
   dengan randomizer: 1 (Tax), 2 (Reward), 3 (Get Out of Jail), 4 (Go To Jail) */
giveChanceCard(P, 1) :- goToTax(P), !.
giveChanceCard(P, 2) :- giveReward(P), !.
giveChanceCard(P, 3) :- giveGetOutOfJailCard(P), !.
giveChanceCard(P, 4) :- goToTax(P), !.

/* Memindahkan player ke tempat tax berikutnya */
goToTax(P) :-
             retract(playerLocation(P, _OldLoc)),
             assertz(playerLocation(P, loc_TX)).

/* Randomize jumlah hadiah dan menambahkan ke 
   dompet pemain */
giveReward(P) :-
               write('Selamat kamu dapet dorpris dari Chance Card!'), nl,
                retract(playerCash(P, OldCash)),
                chanceCardReward(Reward),
                NewCash is OldCash + Reward,
                assertz(playerCash(P, NewCash)).

/* Menambahkan kartu get "Get Out of Jail"
   ke list kartu pemain */
giveGetOutOfJailCard(P) :-
                        write('Kamu dapet FreePass penjara sekali nich'), nl,
                          retract(playerCardList(P, OldList)),
                          assertz(playerCardList(P, [getOutOfJailCard|OldList])).

/* Memindahkan player ke penjara */
goToJail(P) :-
              write('beuh masuk penjara..'), nl,
              retract(playerLocation(P, _OldLoc)),
              assertz(playerLocation(P, loc_JL)),
              assertz(jailTimeLeft(P, 3)).