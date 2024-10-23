-module(p2641).
-export([replace_value_in_tree/1]).

%% Definition for a binary tree node.

-record(tree_node, {val = 0 :: integer(),
                    left = null  :: 'null' | #tree_node{},
                    right = null :: 'null' | #tree_node{}}).

-spec replace_value_in_tree(Root :: #tree_node{} | null) -> #tree_node{} | null.

replace_value_in_tree(Root) ->
    Sums = lists:reverse(sums([Root],[])),
    changed_tree(Root, Root#tree_node.val, Sums).

changed_tree(null, _, _) -> null;
changed_tree(Root, SiblingSum, [DepthSum|LowerSums]) ->
    LSum = (case L=Root#tree_node.left  of null->0; _->L#tree_node.val end),
    RSum = (case R=Root#tree_node.right of null->0; _->R#tree_node.val end),
    ChildrenSum = LSum + RSum,
    LTree = changed_tree(Root#tree_node.left , ChildrenSum, LowerSums),
    RTree = changed_tree(Root#tree_node.right, ChildrenSum, LowerSums),
    #tree_node{val=(DepthSum-SiblingSum), left=LTree, right=RTree}.

sums([], Sums) -> Sums;
sums(NodesOnLevel, HigherSums) ->
    Sum = lists:sum([Node#tree_node.val||Node<-NodesOnLevel]),
    LeftNodes = [Node#tree_node.left||Node<-NodesOnLevel],
    RightNodes = [Node#tree_node.right||Node<-NodesOnLevel],
    LowerNodes = [Node||Node<-(LeftNodes++RightNodes), Node=/=null],
    sums(LowerNodes, [Sum|HigherSums]).