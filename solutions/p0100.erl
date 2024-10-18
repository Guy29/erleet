-module(p0100).
-export([is_same_tree/2]).

%% Definition for a binary tree node.

-record(tree_node, {val = 0 :: integer(),
                    left = null  :: 'null' | #tree_node{},
                    right = null :: 'null' | #tree_node{}}).

-spec is_same_tree(P :: #tree_node{} | null, Q :: #tree_node{} | null) -> boolean().

is_same_tree(null, null) -> true;
is_same_tree(null,  _  ) -> false;
is_same_tree( _  , null) -> false;
is_same_tree(P, Q) ->
    #tree_node{val=PVal,left=PLeft,right=PRight} = P,
    #tree_node{val=QVal,left=QLeft,right=QRight} = Q,
    (PVal==QVal) andalso is_same_tree(PLeft,QLeft) andalso is_same_tree(PRight,QRight).