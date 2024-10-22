-module(p0032).
-export([longest_valid_parentheses/1]).

-spec longest_valid_parentheses(S :: unicode:unicode_binary()) -> integer().

longest_valid_parentheses(S) -> 
    longest_valid_parentheses(0, S, 0, #{}, 0).

longest_valid_parentheses(Index, <<C:8,NextS/binary>>, PrevH, LastAppearance, HighestDiff) ->
    GoingUp = C==$(,
    NewHighestDiff = max(HighestDiff, Index - maps:get(PrevH, LastAppearance, Index)),
    NewLastAppearance =
        if GoingUp -> maps:merge(#{PrevH=>Index}, LastAppearance);
           true -> maps:remove(PrevH, LastAppearance)
        end,
    NewH = PrevH + (if GoingUp->1; true->-1 end),
    longest_valid_parentheses(Index+1, NextS, NewH, NewLastAppearance, NewHighestDiff);

longest_valid_parentheses(Index, <<>>, PrevH, LastAppearance, HighestDiff) ->
    max(HighestDiff, Index - maps:get(PrevH, LastAppearance, Index)).