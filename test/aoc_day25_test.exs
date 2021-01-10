defmodule AOCDay25Test do
  use ExUnit.Case

  alias AOC.Day25

  @testset {5_764_801, 17_807_724}

  @input {14_205_034, 18_047_856}

  test "part 1, testset" do
    {card_pubkey, door_pubkey} = @testset
    assert Day25.bruteforce_loop_size(card_pubkey) == 8
    assert Day25.bruteforce_loop_size(door_pubkey) == 11
    assert Day25.calculate_encryption_key(17_807_724, 8) == 14_897_079
    assert Day25.calculate_encryption_key(5_764_801, 11) == 14_897_079
    assert Day25.part1(@testset) == 14_897_079
  end

  test "part 1, input" do
    assert Day25.part1(@input) == 297_257
  end
end
