-module(p1593).
-export([max_unique_split/1]).

-spec max_unique_split(S :: unicode:unicode_binary()) -> integer().

max_unique_split(S) -> 
    lists:max([num_unique(S,Splits)||Splits<-lists:seq(1,pow(2,size(S)-1))]).

num_unique(S, Splits) -> num_unique(S,1,Splits,[]).

num_unique(S, Index, _, Pieces) when Index>=size(S) ->
    NewPieces = case S of <<>>->Pieces; _->[S|Pieces] end,
    length(maps:keys(#{Piece=>0||Piece<-NewPieces}));
num_unique(S, Index, Splits, Pieces) ->
    NewS      = case Splits rem 2 of 0->S; 1->binary:part(S,Index,size(S)-Index) end,
    NewIndex  = case Splits rem 2 of 0->Index+1; 1->1 end,
    NewPieces = case Splits rem 2 of 0->Pieces; 1->[binary:part(S,0,Index)|Pieces] end,
    NewSplits = Splits div 2,
    num_unique(NewS, NewIndex, NewSplits, NewPieces).

pow(_,0) -> 1;
pow(A,B) ->
    T = pow(A, B div 2),
    case B rem 2 of 0->T*T; _->T*T*A end.