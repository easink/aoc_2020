defmodule AOCDay17Test do
  use ExUnit.Case

  alias AOC.Day17

  @testset """
  .#.
  ..#
  ###
  """

  @input """
  ##......
  .##...#.
  .#######
  ..###.##
  .#.###..
  ..#.####
  ##.####.
  ##..#.##
  """

  test "part 1, testsets" do
    assert Day17.part1(@testset) == 112
  end

  test "part 1, input" do
    assert Day17.part1(@input) == 306
  end

  test "part 2, testset" do
    assert Day17.part2(@testset) == 848
  end

  test "part 2, input" do
    assert Day17.part2(@input) == 2572
  end
end
