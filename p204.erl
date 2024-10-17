% Too slow

-module(p204).
-export([count_primes/1]).

-spec count_primes(N :: integer()) -> integer().

count_primes(N) -> count_primes(N, queue:from_list([2]), 1).
count_primes(N, KnownPrimes, PrimeCount) ->
    P = queue:get_r(KnownPrimes),
    case P >= N of
       true  -> PrimeCount - 1;
       false ->
            NewPrimes = add_prime(KnownPrimes),
            count_primes(N, NewPrimes, PrimeCount+1)
    end.

add_prime(KnownPrimes) -> add_prime(KnownPrimes,queue:get_r(KnownPrimes)+1).
add_prime(KnownPrimes, N) ->
    case is_prime(N, KnownPrimes) of
        true  -> queue:in(N, KnownPrimes);
        false -> add_prime(KnownPrimes, N+1)
    end.

is_prime(N, PrimeQueue) ->
    {{value,Prime}, RemainingPrimes} = queue:out(PrimeQueue),
    case N < Prime*Prime of
        true -> true;
        _ -> case N rem Prime of
                0 -> false;
                _ -> is_prime(N, RemainingPrimes)
             end
    end.