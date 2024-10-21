-module(p1331).
-export([array_rank_transform/1]).

-spec array_rank_transform(Arr :: [integer()]) -> [integer()].

array_rank_transform(Arr) ->
    Ranks = #{V=>I||{I,V}<-lists:enumerate(1,clamp_at_1(Arr))},
    [maps:get(V,Ranks)||V<-Arr].

clamp_at_1(List) -> clamp_at_1(lists:sort(List), []).
clamp_at_1([], Acc) -> lists:reverse(Acc);
clamp_at_1([X|T], Acc=[X|_]) -> clamp_at_1(T,Acc);
clamp_at_1([X|T], Acc) -> clamp_at_1(T,[X|Acc]).