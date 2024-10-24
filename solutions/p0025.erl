-module(p0025).
-export([reverse_k_group/2]).

%% Definition for singly-linked list.

-record(list_node, {val = 0 :: integer(),
                    next = null :: 'null' | #list_node{}}).

-spec reverse_k_group(Head :: #list_node{} | null, K :: integer()) -> #list_node{} | null.

reverse_k_group(Head, K) ->
    [H|Heads] = get_heads(Head, K, []),
    rearrange(K, Heads, H).

get_heads(Head, K, Acc) ->
    {Tail, Remaining} = kth_tail(Head, K),
    case Remaining of
        0 -> get_heads(Tail, K, [Head|Acc]);
        _ -> [Head|Acc]
    end.

rearrange(_, [], Done) -> Done;
rearrange(K, [H|Heads], Done) ->
    rearrange(K, Heads, reverse_onto(H,Done,K)).

reverse_onto(_, B, 0) -> B;
reverse_onto(A, B, K) ->
    #list_node{val=Val, next=Next} = A,
    reverse_onto(Next, #list_node{val=Val, next=B}, K-1).

kth_tail(Root, 0) -> {Root,0};
kth_tail(null, K) -> {null, K};
kth_tail(Root, K) -> kth_tail(Root#list_node.next, K-1).