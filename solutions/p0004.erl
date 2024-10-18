-module(p0004).
-export([find_median_sorted_arrays/2]).

-spec find_median_sorted_arrays(Nums1 :: [integer()], Nums2 :: [integer()]) -> float().

find_median_sorted_arrays(Nums1, Nums2) ->
    {Arr1, Arr2} = {array:from_list(Nums1), array:from_list(Nums2)},
    {  M ,   N } = {array:size(Arr1)      , array:size(Arr2)},
    K = M + N,
    case K rem 2 of
        0 -> (find_nth(Arr1, Arr2, K div 2 - 1) + find_nth(Arr1, Arr2, K div 2)) / 2;
        1 ->  find_nth(Arr1, Arr2, K div 2)
    end.

find_nth(Arr1, Arr2, N) ->
    Start = max(0, N - array:size(Arr2)),
    End   = min(array:size(Arr1), N),
    true  = Start =< End,
    I     = find_nth(Arr1, Arr2, N, Start, End),
    min(array:get(I,Arr1),array:get(N-I,Arr2)).

find_nth(_, _, _, Index, Index) -> Index;
find_nth(Arr1, Arr2, N, Start, End) ->
    I1 = (Start + End + 1) div 2,
    I2 = N - I1,
    V1 = case I1<1 of true->-9999999; false->array:get(I1-1, Arr1) end,
    V2 = array:get(I2, Arr2),
    case V1 < V2 of
        true  -> find_nth(Arr1, Arr2, N, I1, End);
        false -> find_nth(Arr1, Arr2, N, Start, I1-1)
    end.