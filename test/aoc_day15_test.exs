defmodule AOCDay15Test do
  use ExUnit.Case

  alias AOC.Day15

  @testset """
  """

  @input [12, 1, 16, 3, 11, 0]

  test "part 1, testsets" do
    assert Day15.part1([0, 3, 6]) == 436
    assert Day15.part1([1, 3, 2]) == 1
    assert Day15.part1([2, 1, 3]) == 10
    assert Day15.part1([1, 2, 3]) == 27
    assert Day15.part1([2, 3, 1]) == 78
    assert Day15.part1([3, 2, 1]) == 438
    assert Day15.part1([3, 1, 2]) == 1836
  end

  test "part 1, input" do
    assert Day15.part1(@input) == 1696
  end

  # test "part 2, testset" do
  #   assert Day15.part2([0, 3, 6]) == 175_594
  #   assert Day15.part2([1, 3, 2]) == 2578
  #   assert Day15.part2([2, 1, 3]) == 3_544_142
  #   assert Day15.part2([1, 2, 3]) == 261_214
  #   assert Day15.part2([2, 3, 1]) == 6_895_259
  #   assert Day15.part2([3, 2, 1]) == 18
  #   assert Day15.part2([3, 1, 2]) == 362
  # end

  # test "part 2, input" do
  #   assert Day15.part2(@input) == 37385
  # end
end
