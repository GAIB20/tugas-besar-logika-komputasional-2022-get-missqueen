/* FACTS */
/* RULES */

/* isInWorldTour(P);
   Mengembalikan true jika sedang berada di lokasi World Tour */
isInWorldTour(P) :-
                playerLocation(P, wt).

/* evaluateWorldTour(P, LOC, passGO);
   Menjalankan World Tour pada pemain P.
   LOC merupakan akhir lokasi player, dan passGO jika melewati GO */
evaluateWorldTour(P, NewLoc, _) :-
                        moveTo(P, NewLoc).