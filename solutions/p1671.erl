-module(p1671).
-export([minimum_mountain_removals/1]).

-spec minimum_mountain_removals(Nums :: [integer()]) -> integer().

minimum_mountain_removals(Nums) ->
    minimum_mountain_removals(Nums, 0, [{0,0}], []).

minimum_mountain_removals([], _, _, [{Deletions,_}|_]) -> Deletions;
minimum_mountain_removals([Num|Nums], Index, Rising, Falling) ->

    A = [{Deletions+1, Highest} || {Deletions,Highest} <- Rising],
    B = [{Deletions  , Num    } || {Deletions,Highest} <- Rising , Num > Highest],

    NewRising = shorten(lists:merge([A,B])),

    C = [{Deletions+1, Lowest}  || {Deletions, Lowest } <- Falling],
    D = [{Deletions  , -Num  }  || {Deletions, Lowest } <- Falling, Num < -Lowest],
    E = [{Deletions  , -Num  }  || {Deletions, Highest} <- Rising , Num <  Highest,
                                   Index - Deletions >= 2],
                                   
    NewFalling = shorten(lists:merge([C,D,E])),

    minimum_mountain_removals(Nums, Index+1, NewRising, NewFalling).

shorten(Input) -> shorten(Input, []).
shorten([{X,_}|Input], Acc=[{X,_}|_]) -> shorten(Input, Acc);
shorten([Tuple|Input], Acc) -> shorten(Input, [Tuple|Acc]);
shorten([], Acc) -> lists:reverse(Acc).