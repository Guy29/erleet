-module(p0670).
-export([maximum_swap/1]).

-spec maximum_swap(Num :: integer()) -> integer().

% Returns the result of the maximum swap.
maximum_swap(Num) ->
    NumsList = [D-$0 || D <- integer_to_list(Num)],
    SwappedList = case find_swap_locations(NumsList) of
                    {I1,V1,I2,V2} -> replace(replace(NumsList,I1,V2),I2,V1);
                    no_swap -> NumsList
                  end,
    list_to_integer([D+$0 || D <- SwappedList]).

% find_swap_locations(Nums) returns a tuple
% {Index1, Value1, Index2, Value2} at which the swap should
% be made, if there is one, or no_swap otherwise.
find_swap_locations(NumsList) ->
    Maximums = maximums(NumsList),
    find_swap_locations(NumsList, Maximums, 1).
find_swap_locations([],_,_) -> no_swap;
find_swap_locations([H|T],[{HMV,HMI}|TM],I) ->
    if H==HMV -> find_swap_locations(T,TM,I+1);
       true -> {I,H,HMI,HMV}
    end.

% maximums(Nums) returns a list of tuples,
% where the I-th tuple represents the value and index
% of the maximum element in Nums that comes at or after
% index I.
maximums(Nums) ->
    N=length(Nums),
    maximums(lists:reverse(Nums),[{-1,N+1}],N).
maximums([],M,0) -> M;
maximums([V|T], M=[Max={MaxV,_}|_], Index) ->
    NewMax = if V>MaxV->{V,Index}; true->Max end,
    maximums(T, [NewMax|M], Index-1).

% replace(L,N,V) returns a copy of L with its N-th element replaced with V
replace(L,N,V) -> replace(L,N,V,[]).
replace([_|T],1,V,Acc) -> lists:reverse(Acc)++[V|T];
replace([H|T],N,V,Acc) -> replace(T,N-1,V,[H|Acc]).