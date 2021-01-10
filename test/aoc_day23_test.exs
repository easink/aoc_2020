defmodule AOCDay23Test do
  use ExUnit.Case

  alias AOC.Day23

  @testset '389125467'

  @input '398254716'

  test "part 1, testset" do
    assert Day23.part1(@testset, 10) == '92658374'
    assert Day23.part1(@testset, 100) == '67384529'
  end

  test "part 1, input" do
    assert Day23.part1(@input, 100) == '45798623'
  end

  test "part 2, testset" do
    assert Day23.part2(@testset, 10_000_000) == 149_245_887_792
  end

  test "part 2, input" do
    assert Day23.part2(@input, 10_000_000) == 235_551_949_822
  end
end
