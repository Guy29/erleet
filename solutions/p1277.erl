-module(p1277).
-export([count_squares/1]).

-spec count_squares(Matrix :: [[integer()]]) -> integer().

count_squares(Matrix) ->
    count_one_locations(one_locations(Matrix)).

count_one_locations(OneLocations) ->
    case maps:size(OneLocations) of
        0 -> 0;
        _ -> maps:size(OneLocations) + count_one_locations(one_up(OneLocations))
    end.

one_locations(Matrix) ->
    #{{I,J}=>true || {I,Line}<-lists:enumerate(Matrix),
                     {J,Val}<-lists:enumerate(Line),
                     Val==1}.

one_up(OneLocations) ->
    #{{I,J}=>true || {I,J}<-maps:keys(OneLocations),
                     maps:get({I+1,J  }, OneLocations, false) andalso
                     maps:get({I  ,J+1}, OneLocations, false) andalso
                     maps:get({I+1,J+1}, OneLocations, false) }.