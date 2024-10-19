-module(p0018).
-export([four_sum/2]).


-spec four_sum(Nums :: [integer()], Target :: integer()) -> [[integer()]].

four_sum(Nums, Target) ->
    Nums2   = clamp_at(Nums, 4),
    TwoSums = two_sums(Nums2),
    ComboGroups = [{maps:get(K,TwoSums,[]),maps:get(Target-K,TwoSums,[])}
                    || K<-maps:keys(TwoSums), K=<Target-K],
    clamp_at([lists:sort(V)||X<-ComboGroups,{V,I}<-product(X),distinct(I)],1).

distinct(Indices) -> length(clamp_at(Indices,1))==4.

product({A,B}) ->
    [{[V1,V2,V3,V4],[I1,I2,I3,I4]}||[[V1,V2],[I1,I2]]<-A, [[V3,V4],[I3,I4]]<-B].

two_sums(Nums) ->
    maps:groups_from_list(fun([[A,B],_])->A+B end, pairs(Nums,1,[])).

pairs([],_,Acc) -> lists:append(Acc);
pairs([X|T], I, Acc) ->
    pairs(T, I+1, [[[[X,Y],[I,J]]||{J,Y}<-lists:enumerate(I+1,T)]|Acc]).

clamp_at(Nums, Max) -> clamp_at(lists:sort(Nums), Max, null, 0, []).
clamp_at([], _, _, _, Acc) -> Acc;
clamp_at([Num|OtherNums], Max, PrevNum, Count, Acc) ->
    case {Num, Count} of
        {PrevNum, Max} -> clamp_at(OtherNums, Max, Num, Max, Acc);
        {PrevNum, _  } -> clamp_at(OtherNums, Max, Num, Count+1, [Num|Acc]);
        _              -> clamp_at(OtherNums, Max, Num, 1, [Num|Acc])
    end.