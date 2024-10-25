-module(p1233).
-export([remove_subfolders/1]).

-spec remove_subfolders(Folder :: [unicode:unicode_binary()]) -> [unicode:unicode_binary()].

remove_subfolders(Folder) ->
    SortedFolders = lists:sort(Folder),
    remove(SortedFolders, <<"*">>, []).

remove([], _, Acc) -> Acc;
remove([First|Rest], Current, Acc) ->
    S = size(Current),
    case binary:longest_common_prefix([Current, First]) of
        S -> remove(Rest, Current, Acc);
        _ -> remove(Rest, <<First/binary,$/>>, [First|Acc])
    end.