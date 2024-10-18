-module(p0020).
-export([is_valid/1]).

-spec is_valid(S :: unicode:unicode_binary()) -> boolean().

is_valid(S) -> is_valid(S, []).

is_valid(<<>>, []) -> true;
is_valid(<<>>, _) -> false;
is_valid(S, Stack) ->
    <<Char:8, RestOfS/binary>> = S,
    case Char of
        $( -> is_valid(RestOfS, [$)|Stack]);
        ${ -> is_valid(RestOfS, [$}|Stack]);
        $[ -> is_valid(RestOfS, [$]|Stack]);
        _  -> case Stack of
                [] -> false;
                [Char|RestOfStack] -> is_valid(RestOfS, RestOfStack);
                _ -> false
              end
    end.