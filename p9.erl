-module(p9).
-export([is_palindrome/1]).

-spec is_palindrome(X :: integer()) -> boolean().

is_palindrome(X) when X<0 -> false;
is_palindrome(X) -> is_palindrome(X, []).

is_palindrome(0, Acc) -> Acc == lists:reverse(Acc);
is_palindrome(X, Acc) -> is_palindrome(X div 10, [X rem 10|Acc]).