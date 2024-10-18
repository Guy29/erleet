-module(p0024).
-export([swap_pairs/1]).

%% Definition for singly-linked list.

-record(list_node, {val = 0 :: integer(),
                    next = null :: 'null' | #list_node{}}).

-spec swap_pairs(Head :: #list_node{} | null) -> #list_node{} | null.

swap_pairs(Head) -> combine(split(Head,null,null,odd)).

split(null, Odds, Evens, Turn) -> {Odds, Evens, Turn};
split(#list_node{val=Val,next=Next}, Odds, Evens, Turn) ->
    case Turn of
        odd  -> split(Next, #list_node{val=Val,next=Odds}, Evens, even);
        even -> split(Next, Odds, #list_node{val=Val,next=Evens}, odd)
    end.

combine({Odds,Evens,odd }) -> combine(Odds,Evens);
combine({#list_node{val=Val,next=Odds},Evens,even}) ->
    combine(Odds,Evens,#list_node{val=Val,next=null}).

combine(A,B) -> combine(A,B,null).

combine(null,_,Acc) -> Acc;
combine(#list_node{val=Val,next=C},B,Acc) ->
    combine(B,C,#list_node{val=Val,next=Acc}).