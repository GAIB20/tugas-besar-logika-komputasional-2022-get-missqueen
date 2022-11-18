/* getIndex(L,Val,Index) menghasilkan index
   dari elemen bernilai Val yang terdapat
   di dalam List L, yaitu Index */
getIndex([A|B], A, 0).
getIndex([A|B], Val, Index):-
                             getIndex(B, Val, Index1),
                             Index is Index1 + 1.

/* deleteVal(OldList,Val,NewList) menghasilkan 
   index dari elemen bernilai Val yang terdapat
   di dalam List L, yaitu Index */
deleteVal([],Val,[]).
deleteVal([A|B],A,B).
deleteVal([A|B], Val, [A|B1]) :-
                                 deleteVal(B, Val, B1).