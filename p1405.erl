-module(p1405).
-export([longest_diverse_string/3]).

-spec longest_diverse_string(A :: integer(), B :: integer(), C :: integer()) -> unicode:unicode_binary().

longest_diverse_string(A, B, C) -> longest_diverse_string(#{$a=>A,$b=>B,$c=>C}, []).

longest_diverse_string(Map, L) ->
    [X,Y|_] = case L of []->[0,0]; [_]->[0,0]; _->L end,
    Options = [{Count,Letter} || {Letter,Count} <- maps:to_list(Map),
                Count>0, not((Letter==X) and (Letter==Y))],
    case Options of
        [] -> list_to_binary(L);
        _  ->
            {MaxCount, MaxLetter} = lists:max(Options),
            longest_diverse_string(Map#{MaxLetter=>MaxCount-1}, [MaxLetter|L])
    end.