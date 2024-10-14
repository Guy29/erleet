-module(p1).
-export([two_sum/2]).

-spec two_sum(Nums :: [integer()], Target :: integer()) -> [integer()].

two_sum(Nums, Target) -> two_sum(Nums, Target, #{}, 0).

two_sum([H|T], Target, Known_locations, Consumed) ->
    case maps:is_key(Target-H, Known_locations) of
        true  -> [maps:get(Target-H, Known_locations), Consumed];
        false -> two_sum(T, Target, Known_locations#{H=>Consumed}, Consumed+1)
    end.