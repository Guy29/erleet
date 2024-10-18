-module(p0094).
-export([inorder_traversal/1]).

%% Definition for a binary tree node.

-record(tree_node, {val = 0 :: integer(),
                    left = null  :: 'null' | #tree_node{},
                    right = null :: 'null' | #tree_node{}}).

-spec inorder_traversal(Root :: #tree_node{} | null) -> [integer()].

inorder_traversal(null) -> [];
inorder_traversal(#tree_node{val=Val,left=Left,right=Right}) ->
  inorder_traversal(Left) ++ [Val] ++ inorder_traversal(Right).