/* RULES */
/* Mengembalikan jumlah pajak yang harus dibayar pemain */
taxOwed(Player, Tax) :-
    playerPropList(Player, PropList),
    totalPropVal(PropList, PropVal),
    playerCash(Player, Cash),
    TotalAsset is (PropVal+Cash),
    Tax is (1/10)*TotalAsset.

/* Mengurangi cash pemain setelah terkena pajak */
taxed(Player) :-
    taxOwed(Player, Tax),
    format('Bayar ~w buat biaya admin gan.', [Tax]), nl,
    retract(playerCash(Player, (OldCash))),
    NewCash is (OldCash-Tax),
    assertz(playerCash(Player, NewCash)).