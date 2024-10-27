-module(p0030).
-export([find_substring/2]).

-spec find_substring(S :: unicode:unicode_binary(), Words :: [unicode:unicode_binary()]) -> [integer()].

find_substring(S, Words) ->
  WordCounts = word_counts(Words),
  {Values, TargetValue} = word_values(WordCounts, #{}, 1),
  WordLength = size(hd(Words)),
  ConcatLength = length(Words)*WordLength,
  [Index || Start<-lists:seq(0,WordLength-1),
            Index<-match_indices(S, ConcatLength, Values, Start,
                                 WordLength, 0, TargetValue, [])].

word_counts(Words) ->
    WordIndices = maps:groups_from_list(fun({_,W})->W end, lists:enumerate(Words)),
    [{Word,length(Indices)} || {Word,Indices}<-maps:to_list(WordIndices)].

word_values([], Values, NextVal) -> {Values, NextVal-1};
word_values([{Word,Count}|WordCounts], Values, NextVal) ->
    word_values(WordCounts, Values#{Word=>NextVal}, NextVal*(Count+1)).

match_indices(S, _, _, Start, Increment, _, _, Indices) when Start+Increment>size(S) ->
    Indices;
match_indices(S, ConcatLength, Values, Start, Increment, CumValue, TargetValue, Indices) ->
    PartLost    = if Start<ConcatLength-><<>>;
                    true->binary:part(S, Start-ConcatLength, Increment)
                  end,
    ValueLost   = case PartLost of
                    <<>> -> 0;
                    _    -> maps:get(PartLost, Values, TargetValue*2)
                  end,
    PartGained  = binary:part(S, Start, Increment),
    ValueGained = maps:get(PartGained, Values, TargetValue*2),
    NewValue    = CumValue + ValueGained - ValueLost,
    NewIndices  = case NewValue of
                    TargetValue -> [Start + Increment - ConcatLength|Indices];
                    _           -> Indices
                  end,
    match_indices(S, ConcatLength, Values, Start+Increment, Increment,
                  CumValue + ValueGained - ValueLost, TargetValue, NewIndices).