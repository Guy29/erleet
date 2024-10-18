-module(p0017).
-export([letter_combinations/1]).

-spec letter_combinations(Digits :: unicode:unicode_binary()) -> [unicode:unicode_binary()].

-define(LETTERS, #{$2=>"abc",$3=>"def",$4=>"ghi",$5=>"jkl",
                   $6=>"mno",$7=>"pqrs",$8=>"tuv",$9=>"wxyz"}).

letter_combinations(<<>>) -> [];
letter_combinations(Digits) -> letter_combinations(Digits,[<<>>]).

letter_combinations(<<>>, Acc) -> Acc;
letter_combinations(<<Digit:8,Rest/binary>>, Acc) ->
    Acc2 = [[<<Text/binary,C>>||C<-maps:get(Digit,?LETTERS)]||Text<-Acc],
    letter_combinations(Rest, lists:append(Acc2)).