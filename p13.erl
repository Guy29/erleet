-module(p13).
-export([roman_to_int/1]).

-spec roman_to_int(S :: unicode:unicode_binary()) -> integer().

roman_to_int(S) -> roman_to_int(S,0,0).

roman_to_int(<<>>, _, Acc) -> Acc;
roman_to_int(S, PrevChar, Acc) ->
    <<CurrChar:8, NewS/binary>> = S,
    NewAcc = Acc + case {PrevChar,CurrChar} of
             {$I,$V} ->   3; {$I,$X} ->   8;
             {$X,$L} ->  30; {$X,$C} ->  80;
             {$C,$D} -> 300; {$C,$M} -> 800;
             {_,$I} -> 1; {_,$X} -> 10; {_,$C} -> 100;
             {_,$V} -> 5; {_,$L} -> 50; {_,$D} -> 500;
             {_,$M} -> 1000
             end,
    roman_to_int(NewS, CurrChar, NewAcc).