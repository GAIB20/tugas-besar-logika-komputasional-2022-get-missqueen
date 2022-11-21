/* RULES */
/* Mengembalikan jumlah pajak yang harus dibayar pemain */
/* Basis */
taxOwed(pemain1, [], Tax) :-
    playerCash(Cash),
    Tax is Cash.
taxOwed(pemain2, [], Tax) :-
    playerCash(Cash),
    Tax is Cash.
/* Rekurens */
taxOwed(Player, [Prop|TAIL], Tax) :-
    levelProp(Prop, Level),
    cost(Value, Prop, Level),
    taxOwed(Player, TAIL, NextTax),
    Tax is Value+NextTax.

/* Mengurangi cash pemain setelah terkena pajak */
taxed(Player) :-
    playerCash(Player, Cash),
    playerPropList(Player, PropList),
    taxOwed(Player, PropList, Tax),
    assertz(playerCash(Player, (Cash-Tax))).