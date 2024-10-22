-module(p2583).
-export([kth_largest_level_sum/2]).

%% Definition for a binary tree node.

-record(tree_node, {val = 0 :: integer(),
                    left = null  :: 'null' | #tree_node{},
                    right = null :: 'null' | #tree_node{}}).

-spec kth_largest_level_sum(Root :: #tree_node{} | null, K :: integer()) -> integer().

kth_largest_level_sum(Root, K) ->
    Sums = lists:sort(sums([Root],[])),
    case length(Sums) of N when N>=K->lists:nth(N-K+1, Sums); _->-1 end.

sums([], Sums) -> Sums;
sums(NodesOnLevel, HigherSums) ->
    Sum = lists:sum([Node#tree_node.val||Node<-NodesOnLevel]),
    LeftNodes = [Node#tree_node.left||Node<-NodesOnLevel],
    RightNodes = [Node#tree_node.right||Node<-NodesOnLevel],
    LowerNodes = [Node||Node<-(LeftNodes++RightNodes), Node=/=null],
    sums(LowerNodes, [Sum|HigherSums]).