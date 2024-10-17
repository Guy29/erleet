-module(p204).
-export([count_primes/1]).

-spec count_primes(N :: integer()) -> integer().

count_primes(N) -> count_primes(N, primes_new()).
count_primes(N, KnownPrimes) ->
    case primes_largest(KnownPrimes) >= N of
       true  -> primes_length(KnownPrimes) - 1;
       false ->
            NewPrimes = find_next_prime(KnownPrimes, primes_largest(KnownPrimes) + 1),
            count_primes(N, NewPrimes)
    end.

find_next_prime(KnownPrimes, Start) ->
    case is_prime(Start, KnownPrimes) of
        {true,  NewPrimes} -> primes_add(NewPrimes, Start);
        {false, NewPrimes} -> find_next_prime(NewPrimes, Start+1)
    end.

is_prime(K, KnownPrimes) -> is_prime(K, KnownPrimes, KnownPrimes).
is_prime(K, KnownPrimes={[], _}, _) ->
    NewPrimes = primes_cache(KnownPrimes),
    is_prime(K, NewPrimes, NewPrimes);
is_prime(K, {Ascending,Descending}, FullPrimes) ->
    [Prime|RemainingPrimes] = Ascending,
    case {K<Prime*Prime, K rem Prime} of
        {true,_} -> {true, FullPrimes};
        {_, 0}   -> {false, FullPrimes};
        {_, _}   -> is_prime(K, {RemainingPrimes,Descending}, FullPrimes)
    end.


primes_new()                    -> {[2],[2]}.
primes_largest({_,[Largest|_]}) -> Largest.
primes_length({_,Descending})    -> length(Descending).
primes_add({Ascending,Descending},N) -> {Ascending, [N|Descending]}.
primes_cache({_,Descending})     -> {lists:reverse(Descending), Descending}.