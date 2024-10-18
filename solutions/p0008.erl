-module(p8).
-export([my_atoi/1]).

-spec my_atoi(S :: unicode:unicode_binary()) -> integer().

my_atoi(S) -> truncate(my_atoi(S, 0, false, 1)).

my_atoi(<<>>, Acc, _, Sign) -> Sign * Acc;
my_atoi(S, Acc, ReadingDigits, Sign) ->
    <<CurrChar:8, NewS/binary>> = S,
    if ReadingDigits ->
        case CurrChar of
            X when ($0 =< X) and (X =< $9) -> my_atoi(NewS, Acc*10+(X-$0), true, Sign);
            _ -> my_atoi(<<>>, Acc, false, Sign)
        end;

        true ->
        case CurrChar of
            X when (X==$ ) or (X==$\t) -> my_atoi(NewS, Acc, false, Sign);
            $+ -> my_atoi(NewS, Acc, true,  1);
            $- -> my_atoi(NewS, Acc, true, -1);
            X when ($0 =< X) and (X =< $9) -> my_atoi(NewS, Acc*10+(X-$0), true, Sign);
            _ -> my_atoi(<<>>, Acc, false, Sign)
        end
    end.

truncate(X) -> min(max(X,-2147483648),2147483647).