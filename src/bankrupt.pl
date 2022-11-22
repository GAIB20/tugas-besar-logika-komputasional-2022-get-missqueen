/* FACTS */
/* startGame(false)
   Ini dapat diimplementasikan di START atau di END */


/* RULES */
/* willBankrupt(P)
   Mengeluarkan true jika P bound-to-be bangkrut */
willBankrupt(P) :-

/* mortgage(P, CASH)
   Menjalankan penjualan properti pemain P. */
mortgage(P, CASH) :-
    format('Wah uangmu kurang!'), nl.
    format('Apakah kamu ingin melanjutkan permainan?').
