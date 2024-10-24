-module(p0951).
-export([flip_equiv/2]).

%% Definition for a binary tree node.

-record(tree_node, {val = 0 :: integer(),
                    left = null  :: 'null' | #tree_node{},
                    right = null :: 'null' | #tree_node{}}).

-spec flip_equiv(Root1 :: #tree_node{} | null, Root2 :: #tree_node{} | null) -> boolean().

flip_equiv(Root, Root) -> true;
flip_equiv(_, null) -> false;
flip_equiv(null, _) -> false;
flip_equiv(Root1, Root2) ->
    Root1#tree_node.val == Root2#tree_node.val
    andalso
    ((
    flip_equiv(Root1#tree_node.left,Root2#tree_node.left)
    andalso
    flip_equiv(Root1#tree_node.right,Root2#tree_node.right)
    )
    orelse
    (
    flip_equiv(Root1#tree_node.left,Root2#tree_node.right)
    andalso
    flip_equiv(Root1#tree_node.right,Root2#tree_node.left)
    )).