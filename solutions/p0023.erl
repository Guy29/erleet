-module(p0023).
-export([merge_k_lists/1]).

%% Definition for singly-linked list.

-record(list_node, {val = 0 :: integer(),
                    next = null :: 'null' | #list_node{}}).

-spec merge_k_lists(Lists :: [#list_node{} | null]) -> #list_node{} | null.

merge_k_lists(Lists) ->
    NonEmptyLists = [L||L<-Lists, L=/=null],
    case NonEmptyLists of []->null; _-> merge_k_lists(NonEmptyLists, null) end.

merge_k_lists([], Acc) -> reverse(Acc);
merge_k_lists(Lists, Acc) ->
    Tagged     = [{V,I,L}||{I,L=#list_node{val=V}}<-lists:enumerate(Lists)],
    {SmallestVal, ListId, #list_node{next=Rest}} = lists:min(Tagged),
    OtherLists = [L||{_,I,L}<-Tagged, I=/=ListId],
    NewLists   = case Rest of null->OtherLists; _->[Rest|OtherLists] end,
    merge_k_lists(NewLists, #list_node{val=SmallestVal, next=Acc}).

reverse(List) -> reverse(List, null).
reverse(null, Acc) -> Acc;
reverse(List, Acc) ->
    {Val, NewList} = {List#list_node.val, List#list_node.next},
    NewAcc = #list_node{val=Val, next=Acc},
    reverse(NewList, NewAcc).