defmodule AOCDay22Test do
  use ExUnit.Case

  alias AOC.Day22

  @testset """
  Player 1:
  9
  2
  6
  3
  1

  Player 2:
  5
  8
  4
  7
  10
  """

  @input """
  Player 1:
  18
  50
  9
  4
  25
  37
  39
  40
  29
  6
  41
  28
  3
  11
  31
  8
  1
  38
  33
  30
  42
  15
  26
  36
  43

  Player 2:
  32
  44
  19
  47
  12
  48
  14
  2
  13
  10
  35
  45
  34
  7
  5
  17
  46
  21
  24
  49
  16
  22
  20
  27
  23
  """

  test "part 1, testsets" do
    assert Day22.part1(@testset) == 306
  end

  test "part 1, input" do
    assert Day22.part1(@input) == 33561
  end

  test "part 2, testset" do
    assert Day22.part2(@testset) == 291
  end

  test "part 2, input" do
    assert Day22.part2(@input) == 34594
  end
end
