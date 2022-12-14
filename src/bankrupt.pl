/* FACTS */
/* startGame(false)
   Ini dapat diimplementasikan di START atau di END */

/* RULES */
/* mortgage(P, CASH)
   Menjalankan penjualan properti pemain P. */
mortgage(Player, Pay) :-
   playerCash(Player, Cash),
   otherPlayer(NextPlayer),
   (
      (Cash < Pay) -> (
         playerPropList(Player, PropList),
         countLength(PropList, Length),
         (
            (Length > 0) -> (
               write('Masih mau lanjut ga? [y/n]: '),
               read(ValidInput),
               nl,
               /* validateInput(['y', 'n'], Input, ValidInput), */
               (
                  (ValidInput == 'y') -> (
                     sellProperty(Player),
                     playerCash(Player, NewCash),
                     NewPay is NewCash-Pay,
                     (
                        (NewPay < 0) -> (
                           format('Gacukup wey miskin bet dah, butuh ~w lagi. ~n', [NewPay]),
                           nl,
                           mortgageRent(Player, NewPay)
                        ) ; (
                           retract(playerCash(Player, OldCash)),
                           NewNewCash is OldCash-Pay,
                           assertz(playerCash(Player, NewNewCash)),
                           format('Akhirnya ga bakal dikejar rentenir lagi... Uang kamu sekarang adalah ~w. ~n', [NewNewCash])
                        )
                     )
                  ) ; (ValidInput == 'n') -> (
                     write('HAHAHAHAH BROKIE, BYE!!!'), nl,
                     retract(state(_)),
                     assertz(state(false)), 
                     format('Selamat! Player ~w menang!', [NextPlayer]), !
                  ) ; (
                     write('Mulaii dah mulaiii... bayar dulu woiii'), nl, mortgage(Player, Pay)
                  )
               )
            ) ; (
               write('Waduh gapunya properti trus gaada duit wkkwkw BROKIEE, BYE!!!'), nl,
               retract(state(_)),
               assertz(state(false)),
               format('Selamat! Player ~w menang!', [NextPlayer]), !
            )
         )
      ) ; (
         retract(playerCash(Player, OldCash)),
         NewCash is OldCash-Pay,
         assertz(playerCash(Player, NewCash)),
         format('Selesai membayar hutang. Uang kamu sekarang adalah ~w. ~n', [NewCash])
      )
   ), !.

