-module(p0050).
-export([my_pow/2]).

-spec my_pow(X :: float(), N :: integer()) -> float().

my_pow(_, 0) -> 1;
my_pow(X, N) when N>0 ->
  XpowHalfN = my_pow(X, N div 2),
  case N rem 2 of
    0 -> XpowHalfN * XpowHalfN;
    1 -> XpowHalfN * XpowHalfN * X
  end;
my_pow(X, N) when N<0 ->
  my_pow(1/X, -N).