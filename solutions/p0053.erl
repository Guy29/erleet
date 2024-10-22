-module(p0053).
-export([max_sub_array/1]).

-define(NEGINF, -99999999999999999999).

-spec max_sub_array(Nums :: [integer()]) -> integer().
max_sub_array(Nums) -> max_diff(cumulative(Nums,[0]), ?NEGINF, ?NEGINF).

max_diff([], _, Best) -> Best;
max_diff([Num|Nums], Highest, Best) ->
    Diff       = Highest - Num,
    NewBest    = if Diff > Best -> Diff; true -> Best end,
    NewHighest = if Num > Highest -> Num; true -> Highest end,
    max_diff(Nums, NewHighest, NewBest).

cumulative([],Acc) -> Acc;
cumulative([Num|Nums], Acc=[Prev|_]) ->
    cumulative(Nums, [Num+Prev|Acc]).