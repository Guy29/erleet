-module(p10).
-export([is_match/2]).

-define(ALL_CHARS, lists:seq($a,$z)).

-spec is_match(S :: unicode:unicode_binary(), P :: unicode:unicode_binary()) -> boolean().

is_match(S, P) -> automaton_matches(automaton_create(P), S).

automaton_matches([{_,_,Here}], <<>>) -> Here;
automaton_matches(A, <<>>) -> automaton_matches([lists:last(A)],<<>>);
automaton_matches(A, S) ->
    <<FirstChar:8, Rest/binary>> = S,
    automaton_matches(automaton_update(A,FirstChar), Rest).

automaton_create(P) ->
    skip_skippable(automaton_create(P,[],true)).

automaton_create(<<>>, Done, _) -> lists:reverse([{#{},false,false}|Done]);
automaton_create(P, Done, ZerothState) ->
    <<FirstChar:8, AfterFirst/binary>> = P,
    Matches = case FirstChar of $.->?ALL_CHARS; _->[FirstChar] end,
    {Transitions, Skippable, Rest} =
        case AfterFirst of
            <<>> -> {#{C=>{no,next}||C<-Matches}, false, <<>>};
            <<SecondChar:8, AfterSecond/binary>> ->
                case SecondChar of
                    $* -> {#{C=>{stay,next}||C<-Matches}, true, AfterSecond};
                    _ -> {#{C=>{no,next}||C<-Matches}, false, AfterFirst}
                end
        end,
    State = {Transitions, Skippable, ZerothState},
    automaton_create(Rest, [State|Done], false).

automaton_update(A,C) ->
    skip_skippable(automaton_update(C, [], A, false)).

automaton_update(_, Done, [], _) -> lists:reverse(Done);
automaton_update(C, Done, NotDone, NewlyHere) ->
    [CurrState|Remaining] = NotDone,
    {Transitions, Skippable, Here} = CurrState,
    case Here of
        false ->
            automaton_update(C, [{Transitions,Skippable,NewlyHere}|Done], Remaining, false);
        true ->
            CTransitions = maps:get(C, Transitions, leave),
            Active = NewlyHere orelse
                    case CTransitions of {stay,_}->true; _->false end,
            Going = case CTransitions of {_,next}->true; _->false end,
            automaton_update(C, [{Transitions,Skippable,Active}|Done], Remaining, Going)
    end.

skip_skippable(A) -> skip_skippable(A, [], false).
skip_skippable([],Done,_) -> lists:reverse(Done);
skip_skippable([{Transitions,Skippable,Here}|Remaining], Done, Arriving) ->
    NewHere = Here or Arriving,
    Going = NewHere and Skippable,
    skip_skippable(Remaining, [{Transitions,Skippable,NewHere}|Done], Going).