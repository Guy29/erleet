-module(p0089).
-export([gray_code/1]).

-spec gray_code(N :: integer()) -> [integer()].

gray_code(0) -> [0];
gray_code(N) ->
    K = pow(2,N-1),
    G = gray_code(N-1),
    G ++ lists:reverse([X bxor K||X<-G]).

pow(_,0) -> 1;
pow(N,K) ->
    T = pow(N, K div 2),
    T * T * (case K rem 2 of 0->1; 1->N end).