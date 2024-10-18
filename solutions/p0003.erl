-module(p3).
-export([length_of_longest_substring/1]).

-spec length_of_longest_substring(S :: unicode:unicode_binary()) -> integer().

length_of_longest_substring(S) ->
    Last_seen = #{Char=>-1 || <<Char:8>> <= S},
    length_of_longest_substring(S, Last_seen, 0, 0, 0).

length_of_longest_substring(<<>>, _, _, _, Best) -> Best;
length_of_longest_substring(<<H:8,T/binary>>, Last_seen, Current_location, Run_length, Best) ->
    Length_since_last = Current_location - maps:get(H, Last_seen),
    New_run_length    = min(Length_since_last, Run_length+1),
    New_best          = max(New_run_length, Best),
    length_of_longest_substring(T, Last_seen#{H=>Current_location},
        Current_location+1, New_run_length, New_best).