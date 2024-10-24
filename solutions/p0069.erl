-module(p0069).
-export([my_sqrt/1]).

-spec my_sqrt(X :: integer()) -> integer().

my_sqrt(X) ->
    binary_search(fun(N)->(N*N=<X) end, 0, 65536).

binary_search(_, Start, End) when End-Start==1 -> Start;
binary_search(Pred, Start, End) ->
    Mid = (Start + End) div 2,
    case Pred(Mid) of
        true -> binary_search(Pred, Mid, End);
        false -> binary_search(Pred, Start, Mid)
    end.