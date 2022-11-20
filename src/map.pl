:- dynamic(titMap/3). % titMap(X, Y, Objek)

/* Deklarasi fakta */
titMap(9, 9, '| Go'). % tile air
titMap(9, 8, '| H2').
titMap(9, 7, '| H1').
titMap(9, 6, '| CC').
titMap(9, 5, '| TX').
titMap(9, 4, '| G3').
titMap(9, 3, '| G2').
titMap(9, 2, '| G1').

titMap(9, 1, 'WT').
titMap(8, 1, 'F3 |').
titMap(7, 1, 'F2 |').
titMap(6, 1, 'F1 |').
titMap(5, 1, 'CC |').
titMap(4, 1, 'E3 |').
titMap(3, 1, 'E2 |').
titMap(2, 1, 'E1 |').
titMap(1, 1, ' FF |').

titMap(1, 2, ' D3 |').
titMap(1, 3, ' D2 |').
titMap(1, 4, ' D1 |').
titMap(1, 5, ' TX |').
titMap(1, 6, ' C3 |').
titMap(1, 7, ' C2 |').
titMap(1, 8, ' C1 |').

titMap(1, 9, ' JL').
titMap(2, 9, '| B3').
titMap(3, 9, '| B2').
titMap(4, 9, '| B1').
titMap(5, 9, '| CC').
titMap(6, 9, '| A3').
titMap(7, 9, '| A2').
titMap(8, 9, '| A1').

mapSize(9, 9).

/* Deklarasi rules */

/* Batas kiri */	
printtitMap(X, Y) :- 
	mapSize(_, H),
	X =:= 0,
	Y =< H+1,
	write('|'),
	NextX is X+1,
	printtitMap(NextX, Y),!.

/* Batas atas */
printtitMap(X, Y) :- 
	mapSize(W, _),
	X > 0, X < W + 1,
	Y =:= 0,
	write('-'),
	NextX is X+1,
	printtitMap(NextX, Y),!.

/* Batas kanan */
printtitMap(X, Y) :- 
	mapSize(W, H),
	X =:= W + 1,
	Y =< H + 1,
	write('| '), nl,
	NextY is Y+1,
	printtitMap(0, NextY),!.

/* Batas bawah */				
printtitMap(X, Y) :- 
	mapSize(W, H),
	X > 0, X < W + 1,
	Y =:= H + 1,
	write('-'),
	NextX is X+1,
	printtitMap(NextX, Y),!.			

/* Objek dalam peta */
printtitMap(X, Y) :- 
	mapSize(W, H),
	X > 0, X < W + 1,
	Y > 0, Y < H + 1,
	titMap(X, Y, Obj), !,
	format('~w ', [Obj]),
	NextX is X+1,
	printtitMap(NextX, Y),!.

/* Tile kosong */
printtitMap(X, Y) :- 
	mapSize(W, H),
	X > 0, X < W + 1,
	Y > 0, Y < H + 1,
	(\+ titMap(X, Y, _)),
	write('     '),
	NextX is X+1,
	printtitMap(NextX, Y),!.

printtitMap(_,_) :- !.

map :- 	
	printtitMap(0, 0).