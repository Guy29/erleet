% Too slow

-module(p204_2).
-export([count_primes/1]).

-spec count_primes(N :: integer()) -> integer().

count_primes(N) -> count_primes(N, queue:from_list([2]), 1, 2).
count_primes(N, KnownPrimes, PrimeCount, LargestPrime) ->
    case LargestPrime >= N of
       true  -> PrimeCount - 1;
       false ->
            {NewLargestPrime, NewPrimes} = add_prime(KnownPrimes, LargestPrime + 1),
            count_primes(N, NewPrimes, PrimeCount+1, NewLargestPrime)
    end.

add_prime(KnownPrimes, N) ->
    case is_prime(N, KnownPrimes) of
        true  -> {N, queue:in(N, KnownPrimes)};
        false -> add_prime(KnownPrimes, N+1)
    end.

is_prime(N, PrimeQueue) ->
    {{value,Prime}, RemainingPrimes} = queue:out(PrimeQueue),
    case {N<Prime*Prime, N rem Prime} of
        {true,_} -> true;
        {_, 0}   -> false;
        {_, _}   -> is_prime(N, RemainingPrimes)
    end.