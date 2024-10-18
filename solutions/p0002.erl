-module(p2).
-export([add_two_numbers/2]).

-record(list_node, {val = 0 :: integer(), next = null :: 'null' | #list_node{}}).

-spec add_two_numbers(L1 :: #list_node{} | null, L2 :: #list_node{} | null) -> #list_node{} | null.

add_two_numbers(L1,L2) -> add_two_numbers(L1,L2,0,null).

add_two_numbers(#list_node{val=V1,next=N1}, #list_node{val=V2,next=N2}, Carry, Acc) ->
    Total     = V1 + V2 + Carry,
    V         = Total rem 10,
    New_carry = Total div 10,
    case {N1,N2,New_carry} of
        {null, null, 0} -> reverse(#list_node{val=V,next=Acc},null);
        _ ->
            N1_ = case N1 of null->#list_node{}; _->N1 end,
            N2_ = case N2 of null->#list_node{}; _->N2 end,
            add_two_numbers(N1_,N2_,New_carry,#list_node{val=V,next=Acc})
    end.

reverse(null,L2) -> L2;
reverse(#list_node{val=V,next=N}, L2) -> reverse(N, #list_node{val=V,next=L2}).