-module(p0006).
-export([convert/2]).

-spec convert(S :: unicode:unicode_binary(), NumRows :: integer()) -> unicode:unicode_binary().

convert(S, 1) -> S;
convert(S, NumRows) ->
    convert(S, [{I,<<>>} || I <- lists:seq(1,NumRows)], []).

convert(<<>>, [], PrevRows = [{1,_}|_]) ->
    << T || {_,T} <- PrevRows>>;
convert(<<>>, [NextRow|NextRows], PrevRows) ->
    convert(<<>>, NextRows, [NextRow|PrevRows]);
convert(S, [], [PrevRow|PrevRows]) ->
    convert(S, PrevRows, [PrevRow]);
convert(S, NextRows, PrevRows) ->
    <<FirstChar:8, NewS/binary>> = S,
    [{I,CurrentRow} | NewNextRows] = NextRows,
    NewRow = {I, <<CurrentRow/binary, FirstChar:8>>},
    convert(NewS, NewNextRows, [NewRow | PrevRows]).