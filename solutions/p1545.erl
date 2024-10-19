-module(p1545).
-export([find_kth_bit/2]).

-spec find_kth_bit(N :: integer(), K :: integer()) -> char().

find_kth_bit(N, K) -> find_kth_bit(N,K,0) + $0.

find_kth_bit(1, _, Flip) -> Flip;
find_kth_bit(N, K, Flip) ->
    Midpoint = pow(2,N-1),
    if K == Midpoint -> 1-Flip;
       K <  Midpoint -> find_kth_bit(N-1,K,Flip);
       K >  Midpoint -> find_kth_bit(N-1,Midpoint*2-K,1-Flip)
    end.

pow(_,0) -> 1;
pow(A,B) ->
    T = pow(A, B div 2),
    case B rem 2 of 0->T*T; _->T*T*A end.