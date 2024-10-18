-module(p7).
-export([reverse/1]).

-spec reverse(X :: integer()) -> integer().

reverse(X) when X<0 -> -reverse(-X);
reverse(X) -> truncate(list_to_integer(lists:reverse(integer_to_list(X)))).

truncate(X) when (X<2147483648) and (X>=-2147483648) -> X;
truncate(_) -> 0.