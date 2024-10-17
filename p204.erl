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

find_next_prime(KnownPrimes, N) ->
    case is_prime(N, KnownPrimes) of
        {true,  NewPrimes} -> primes_add(NewPrimes, N);
        {false, NewPrimes} -> find_next_prime(NewPrimes, N+1)
    end.

is_prime(N, KnownPrimes) -> is_prime(N, KnownPrimes, KnownPrimes).
is_prime(N, KnownPrimes={[], _}, _) ->
    NewPrimes = primes_cache(KnownPrimes),
    is_prime(N, NewPrimes, NewPrimes);
is_prime(N, {Forwards,Backwards}, FullPrimes) ->
    [Prime|RemainingPrimes] = Forwards,
    case {N<Prime*Prime, N rem Prime} of
        {true,_} -> {true, FullPrimes};
        {_, 0}   -> {false, FullPrimes};
        {_, _}   -> is_prime(N, {RemainingPrimes,Backwards}, FullPrimes)
    end.


primes_new()                    -> {[2],[2]}.
primes_largest({_,[Largest|_]}) -> Largest.
primes_length({_,Backwards})    -> length(Backwards).
primes_add({Forwards,Backwards},N) -> {Forwards, [N|Backwards]}.
primes_cache({_,Backwards})     -> {lists:reverse(Backwards), Backwards}.