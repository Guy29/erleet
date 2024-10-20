-module(p1106).
-export([parse_bool_expr/1]).

-spec parse_bool_expr(Expression :: unicode:unicode_binary()) -> boolean().

parse_bool_expr(Expression) ->
    <<Char:8, AfterChar/binary>> = Expression,
    {Value, AfterExpr} =
        case Char of
            $t -> {true,  AfterChar};
            $f -> {false, AfterChar};
            _  ->
                << $( , ExprList/binary >> = AfterChar,
                {Values, AfterList} = read_list(ExprList, []),
                case Char of
                    $! -> {not hd(Values), AfterList};
                    $& -> {lists:foldl(fun(A,B)-> A and B end, true, Values), AfterList};
                    $| -> {lists:foldl(fun(A,B)-> A or B end, false, Values), AfterList}
                end
        end,
    case AfterExpr of <<>>->Value; _->{Value, AfterExpr} end.

read_list(ExprList, ExprValues) ->
    {ExprValue, AfterExpr} = parse_bool_expr(ExprList),
    case AfterExpr of
        << $, , RestOfList/binary >> -> read_list(RestOfList, [ExprValue|ExprValues]);
        << $) ,  AfterList/binary >> -> {[ExprValue|ExprValues], AfterList}
    end.