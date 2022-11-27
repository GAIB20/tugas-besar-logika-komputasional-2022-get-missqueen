/* getIndex(L,Val,Index) menghasilkan index
   dari elemen bernilai Val yang terdapat
   di dalam List L, yaitu Index */
getIndex([A|_B], A, 0).
getIndex([_A|B], Val, Index):-
                             getIndex(B, Val, Index1),
                             Index is Index1 + 1.

/* Get Value Dalam List berdasarkan Index */
/* getVal(List, Index, ResultValue) */
getVal([H|_], 0, H).
getVal([_|TAIL], Index, Val) :-
    Index > 0,
    I is Index-1,
    getVal(TAIL, I, Val).

/* deleteVal(OldList,Val,NewList) menghasilkan 
   index dari elemen bernilai Val yang terdapat
   di dalam List L, yaitu Index */
deleteVal([], _Val,[]).
deleteVal([A|B],A,B).
deleteVal([A|B], Val, [A|B1]) :-
                                 deleteVal(B, Val, B1).

/* deleteAt(OldList, Index, NewList) */
deleteAt([], _Index, []).
deleteAt([_A|B], 0, B).
deleteAt([_A|B], Index, [_A|T]) :-
   NextIndex is Index-1,
   deleteAt(B, NextIndex, T).

/* IN LIST */
/* Mengecek apakah SearchedElement ada di List */
/* syntax: inList(List,SearchedElement,Result)
/* Basis */
inList([],_,0).
inList([H|_],H,1).
/* Rekurens */
inList([H|T],SearchedElement,Result)    :-
    H \== SearchedElement,
    inList(T,SearchedElement,Result).

/* Validasi Input */
validateInput(ListOfValids, Input, ValidInput) :-
   inList(ListOfValids, Input, Result),
   (Result == 0) -> (
      format('Weh, input yang bener dong. Silakan input lagi ~n', []),
      nl,
      read(NewInput),
      validateInput(ListOfValids, NewInput, ValidInput)
   ) ; ValidInput is Input.