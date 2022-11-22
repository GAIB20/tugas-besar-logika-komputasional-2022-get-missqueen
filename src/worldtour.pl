:- [player].

/* FACTS */
# playerLocation(p1, wt).
# playerLocation(p2, notwt).

/* RULES */

/* isInWorldTour(P);
   Mengembalikan true jika sedang berada di lokasi World Tour */
isInWorldTour(P) :-
                playerLocation(P, wt).

/* evaluateWorldTour(P, LOC, passGO);
   Menjalankan World Tour pada pemain P.
   LOC merupakan akhir lokasi player, dan passGO jika melewati GO */
evaluateWorldTour(P, NewLoc, OldLoc) :-
                        retract(playerLocation(P, OldLoc)),
                        NewLoc is LOC, !,
                        assertz(playerLocation(P, NewLoc)),
                        retract(playerCash(P, OldVal)),
                        NewVal is OldVal + 100,
                        assertz(playerCash(P, NewVal)).