-module(p2490).
-export([is_circular_sentence/1]).

-spec is_circular_sentence(Sentence :: unicode:unicode_binary()) -> boolean().

is_circular_sentence(Sentence) ->
    case binary:at(Sentence,0)==binary:at(Sentence,size(Sentence)-1) of
        true -> is_circular(Sentence);
        _ -> false
    end.
  

is_circular(<<>>) -> true;
is_circular(<<X:8,$ ,Y:8,Rest/binary>>) ->
    case X of
        Y -> is_circular(<<Y:8,Rest/binary>>);
        _ -> false
    end;
is_circular(<<_:8,Rest/binary>>) -> is_circular(Rest).