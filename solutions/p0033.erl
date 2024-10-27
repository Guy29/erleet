-module(p0033).
-export([search/2]).

-spec search(Nums :: [integer()], Target :: integer()) -> integer().

search(Nums, Target) ->
    Arr   = array:from_list(Nums),
    Pivot = binary_search(
                fun(I) -> array:get(I,Arr) >= hd(Nums) end,
                0, length(Nums)),
    {Start, End} = if Target>=hd(Nums) -> {0,Pivot+1};
                      true             -> {Pivot+1,length(Nums)}
                   end,
    Index = binary_search(
                fun(I) -> array:get(I,Arr) =< Target end,
                Start, End),
    case array:get(Index,Arr) of Target->Index; _->-1 end.

binary_search(_, Start, End) when End-Start=<1 -> Start;
binary_search(Pred, Start, End) ->
    Mid = (Start + End) div 2,
    case Pred(Mid) of
        true -> binary_search(Pred, Mid, End);
        false -> binary_search(Pred, Start, Mid)
    end.