-module(p2458).
-export([tree_queries/2]).

%% Definition for a binary tree node.

-record(tree_node, {val = 0 :: integer(),
                    left = null  :: 'null' | #tree_node{},
                    right = null :: 'null' | #tree_node{}}).

-spec tree_queries(Root :: #tree_node{} | null, Queries :: [integer()]) -> [integer()].

tree_queries(Root, Queries) ->
    D = depth_groups(depths(Root, 0)),
    [maps:get(V,D) || V<-Queries].

depth_groups({Ds1,_}) ->
    Ds = lists:flatten(Ds1),
    U = maps:groups_from_list(fun({_,D,_})->D end, fun({V,_,H})->{-H,V} end, Ds),
    Q = #{D=>lists:sort(R) || {D,R}<-maps:to_list(U)},
    #{V=>(case R of [{NegH,V}]->D-1; [{NegH,V},{NegH2,_}|_]->D-NegH2; [{NegH0,_}|_]->D-NegH0 end) || {D,R}<-maps:to_list(Q), {NegH,V}<-R}.

depths(null, _) -> {[],-1};
depths(Root, Q) ->
    {LD,LH} = depths(Root#tree_node.left, Q+1),
    {RD,RH} = depths(Root#tree_node.right, Q+1),
    {[[{Root#tree_node.val,Q,max(LH,RH)+1}], LD, RD], max(LH,RH)+1}.