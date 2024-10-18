-module(p0014).
-export([longest_common_prefix/1]).
-compile({nowarn_unused_function, [match_length2/1]}).

-spec longest_common_prefix(Strs :: [unicode:unicode_binary()]) -> unicode:unicode_binary().

longest_common_prefix(Strs) -> binary:part(hd(Strs), 0, match_length(Strs)).

% Both match_length and match_length2 take a list of binary
% strings and return the length of the longest match.

match_length(Strs) -> match_length(Strs,0).
match_length([<<>>|_],N) -> N;
match_length(Strs,N) ->
    <<C:8,_/binary>> = hd(Strs),
    NewStrs = [R || <<D,R/binary>> <- Strs, D==C],
    case length(NewStrs)==length(Strs) of
        true -> match_length(NewStrs,N+1);
        _    -> N
    end.

match_length2(Strs) -> binary:longest_common_prefix(Strs).