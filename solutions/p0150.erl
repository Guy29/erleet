-module(p0150).
-export([eval_rpn/1]).

-spec eval_rpn(Tokens :: [unicode:unicode_binary()]) -> integer().

eval_rpn(Tokens) -> eval_rpn(Tokens, []).

eval_rpn([], Stack) -> hd(Stack);
eval_rpn([Token|RemTokens], Stack) ->
    NewStack = case Token of
        <<"+">> -> [A,B|C] = Stack, [B+A|C];
        <<"-">> -> [A,B|C] = Stack, [B-A|C];
        <<"*">> -> [A,B|C] = Stack, [B*A|C];
        <<"/">> -> [A,B|C] = Stack, [B div A|C];
        N -> [binary_to_integer(N)|Stack]
        end,
    eval_rpn(RemTokens, NewStack).