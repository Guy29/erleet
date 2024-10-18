-module(p2044).
-export([count_max_or_subsets/1]).

-spec count_max_or_subsets(Nums :: [integer()]) -> integer().
count_max_or_subsets(Nums) ->
    MaxOr = lists:foldl(fun(A,B)->A bor B end, 0, Nums),
    count_or(Nums, 0, MaxOr).

count_or([], OrAcc, Target) -> if OrAcc==Target->1; true->0 end;
count_or([Num|Rest], OrAcc, Target) ->
    count_or(Rest, OrAcc, Target) + count_or(Rest, OrAcc bor Num, Target).