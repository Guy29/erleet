-module(p0029).
-export([divide/2]).

-spec divide(Dividend :: integer(), Divisor :: integer()) -> integer().

divide(Dividend, Divisor) ->
    Sign = if (Dividend>0)==(Divisor>0)->1; true->-1 end,
    clamp(Sign*divide2(abs(Dividend),[{abs(Divisor),1}])).

divide2(Dividend,[{R,_}|Rest]) when R>Dividend ->
    divide3(Dividend,Rest,0);
divide2(Dividend,Subs=[{R,M}|_]) ->
    divide2(Dividend,[{R+R,M+M}|Subs]).

divide3(_, [], Acc) -> Acc;
divide3(Dividend, [{R,M}|Rest], Acc) when R=<Dividend ->
    divide3(Dividend-R, Rest, Acc+M);
divide3(Dividend, [_|Rest], Acc) ->
    divide3(Dividend, Rest, Acc).

clamp(N) -> max(min(N,2147483647),-2147483648).