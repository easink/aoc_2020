defmodule AOCDay13Test do
  use ExUnit.Case

  alias AOC.Day13

  @testset """
  939
  7,13,x,x,59,x,31,19
  """

  @input """
  1000299
  41,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,37,x,x,x,x,x,971,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,17,13,x,x,x,x,23,x,x,x,x,x,29,x,487,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,19
  """

  test "part 1, testsets" do
    assert Day13.part1(@testset) == 295
  end

  test "part 1, input" do
    assert Day13.part1(@input) == 156
  end

  @testset2 """
  000
  17,x,13,19
  """

  @testset3 """
  000
  67,7,59,61
  """

  @testset4 """
  000
  67,x,7,59,61
  """

  @testset5 """
  000
  67,7,x,59,61
  """

  @testset6 """
  000
  1789,37,47,1889
  """

  test "part 2, testset" do
    assert Day13.part2_stolen(@testset) == 1_068_781
    assert Day13.part2_stolen(@testset2) == 3417
    assert Day13.part2_stolen(@testset3) == 754_018
    assert Day13.part2_stolen(@testset4) == 779_210
    assert Day13.part2_stolen(@testset5) == 1_261_476
    assert Day13.part2_stolen(@testset6) == 1_202_161_486
  end

  # @tag timeout: :infinity
  test "part 2, input" do
    assert Day13.part2_stolen(@input) == 59435
  end
end
