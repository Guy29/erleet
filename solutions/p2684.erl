-module(p2684).
-export([max_moves/1]).

-spec max_moves(Grid :: [[integer()]]) -> integer().

max_moves(Grid) ->
    [LastCol|OtherCols] = transpose_and_reverse(Grid, []),
    InitialWays = #{I=>{0,V}||{I,V}<-lists:enumerate(LastCol)},
    max_moves(OtherCols, InitialWays).

max_moves([], Ways) -> {W,_}=lists:max(maps:values(Ways)), W;
max_moves([Col|Cols], Ways) ->
    Candidates = [{I, ColItem,
                  [W+1||{W,V}<-[maps:get(I-1,Ways,null),
                                maps:get(I  ,Ways,null),
                                maps:get(I+1,Ways,null)], V>ColItem]}
                  ||{I,ColItem}<-lists:enumerate(Col)],
    NewWays = #{I=>{lists:max([0|Cands]),V}||{I,V,Cands}<-Candidates},
    max_moves(Cols, NewWays).

transpose_and_reverse([[]|_], Acc) -> Acc;
transpose_and_reverse(Matrix, Acc) ->
    Heads = [hd(Row)||Row<-Matrix],
    Tails = [tl(Row)||Row<-Matrix],
    transpose_and_reverse(Tails, [Heads|Acc]).