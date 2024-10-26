-module(p0034).
-export([search_range/2]).

-spec search_range(Nums :: [integer()], Target :: integer()) -> [integer()].

search_range(Nums, Target) ->
    Arr = array:from_list(Nums),
    A = binary_search(fun(I)->I==-1 orelse array:get(I,Arr)<Target end, -1,  array:size(Arr)),
    B = binary_search(fun(I)->I==-1 orelse array:get(I,Arr)=<Target end, -1,  array:size(Arr)),
    C = case A+1<array:size(Arr) andalso array:get(A+1,Arr)==Target of true->A+1; false->-1 end,
    D = case B>=0 andalso array:get(B,Arr)==Target of true->B; false->-1 end,
    [C,D].

binary_search(_, Start, End) when End-Start=<1 -> Start;
binary_search(Pred, Start, End) ->
    Mid = (Start + End) div 2,
    case Pred(Mid) of
        true -> binary_search(Pred, Mid, End);
        false -> binary_search(Pred, Start, Mid)
    end.