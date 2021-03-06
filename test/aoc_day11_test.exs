defmodule AOCDay11Test do
  use ExUnit.Case

  alias AOC.Day11

  @testset1 """
  L.LL.LL.LL
  LLLLLLL.LL
  L.L.L..L..
  LLLL.LL.LL
  L.LL.LL.LL
  L.LLLLL.LL
  ..L.L.....
  LLLLLLLLLL
  L.LLLLLL.L
  L.LLLLL.LL
  """

  @testset2 """
  #.##.##.##
  #######.##
  #.#.#..#..
  ####.##.##
  #.##.##.##
  #.#####.##
  ..#.#.....
  ##########
  #.######.#
  #.#####.##
  """

  @testset3 """
  #.LL.L#.##
  #LLLLLL.L#
  L.L.L..L..
  #LLL.LL.L#
  #.LL.LL.LL
  #.LLLL#.##
  ..L.L.....
  #LLLLLLLL#
  #.LLLLLL.L
  #.#LLLL.##
  """

  @testset4 """
  #.##.L#.##
  #L###LL.L#
  L.#.#..#..
  #L##.##.L#
  #.##.LL.LL
  #.###L#.##
  ..#.#.....
  #L######L#
  #.LL###L.L
  #.#L###.##
  """

  @testset5 """
  #.#L.L#.##
  #LLL#LL.L#
  L.L.L..#..
  #LLL.##.L#
  #.LL.LL.LL
  #.LL#L#.##
  ..L.L.....
  #L#LLLL#L#
  #.LLLLLL.L
  #.#L#L#.##
  """

  @testset6 """
  #.#L.L#.##
  #LLL#LL.L#
  L.#.L..#..
  #L##.##.L#
  #.#L.LL.LL
  #.#L#L#.##
  ..L.L.....
  #L#L##L#L#
  #.LLLLLL.L
  #.#L#L#.##
  """

  @input """
  LLLLL.LLLL.LL..LLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLLLLLLLLLL.L.LLLLLLLLL.LLLLLLL.LLLL.LLLLLLLL
  LLLLLLLL.LLLLL.LLLLLLLLLLLLLLLL.LLLLLLLL.LLLLLLLLLLLL.LLLLLLLLLLLLLLL.LL.LLL.LLLL.LLLLLLLL
  LLLLLLLLL.LLLLLLLLLLLLLLLLLLLLL.LLLLLLL..LLLLLL.LLLLLLLLLL..LLLLLLLL.LLLLLLLLL.LLLLLLLLLLL
  LLLLL.LLLLLLLL.LLLLLL.LLLLLLLLL.LLLLLLLL..LLLLL.LLLLL.LLLLLLLLLLLLLLL.L.LLLLLLLLL.LLL.LLLL
  LLLLL.LLL.L..L.LLLLL.LLL.LLLLLLLLLLLLLLL.LL.LLLLLLL.L.LLL..LLLLLLLLL.LLLLLLL.LLLL.LLLLLLLL
  LLLLL.LLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLL.LLLLLL.LLLLLLLLLL.LLLLLL.LL.LLLLLLLLLLLL.LLLL.LLL
  LLLLL.LLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLLLLLLLLL.L.LLLLLLLLLLLLL
  L.L..LLL.......LL.LL.L.L....L..............L..LL.......L...L....LL....L.L..LL.....L.L.....
  LLLLL.LLLLLLL.LLLLLLLLLL.LLLLLL.LLLLL..L.LLLLLL.LLLLL.LLLL.LLLL.LLLL.LLLLLLL.LLLL.L.LLLLLL
  LLLLL.LLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLL.L.LLL.LLLL.LLLLLLLLL.LLLLLLL.LLLLL.LL.LLLL
  LLLLL.LLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLL.LLLL.LLLLLLLLLLLL..LLLLLLLL.LLLLLLL.LLLL.LLLLLLLL
  LLLLLLLLLLLLLLLL.LLLLLLL.LLLL.L.LLLLLLLLLLLLLLL.LLLLLLLLLL.LLLLLLLLLL.LLLLL.LLLLL.LL.LLLLL
  L.LLL.LLLLLLLLLLLLLLLLLL.LLLLLL.LLLLLLLLLL.L.LL.L.LLL.LLLL.LLLLLLLLLLLLLLLLL.L.LL.LLLLLLLL
  LLLLLLLLLLLLLL.LLLLLLLLLLLLLLLL.LLLL.LLL.LLLLLL.LLLLL.LLLL.LLLLLLLLL.LLLLLLL.LLLL.LLLLLLLL
  LLLLLLLLLLLLLLLLLLLLLLLL.LLLLLL.LLLLLLLL.LL.LL..LLLLL.LLLL.LLLLL.LLL.L.LLL.L.LLLL.L.LLLLLL
  LLLLL.LLLLLLLL.LLLLLLLLL.LLLL.LLLLLLLLLL.LLLLLL.LLLLL.LLLL.LLLLLLLLL.LLLLLLLLLLLL.LLLLLLLL
  .LLL..LLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLLL.LLLLLLLLLLLL.LLLL.L.LLLLL.L.LLLLLLLLLLLL.LLLLLLLL
  L.L.L.....LLL...L...L..LL...L.LL......LLLL.L.LL..LLL.L..L.......L..L.L....LLL.....L.L...L.
  LLLLL.LLLL.LLLLLLLLLLLLL.LLLLLL.LL.LLLLL.LLLLLLL.LLLL.LLLL.LLLL.LLL.LLLLLLLL.LLLLLLLLLLLLL
  LLLLL.L.LLLLLLL.LL.LLLLL.L.LLLLLLLLLLLLL.LLLLLL.LLLLL.LLLLLLLLLLLLLLLLLLLLLL..LLL.LLLLLLLL
  LLLLL.LLLLLLLLLLLLLLLLLL.LLLLLL.LLLLLLLL.LLLLLL.LLLLL.L..L.LLLLLLLLLLLLLLLLLLLLLLLLL.LLLL.
  LLLLL.LLLLLLLLLLLLLLLLLL.LLLLLL.LLLLLLLLLLLLL.L.L.LLL.LLLL.LLLLL.LLL.LLLLLLLLLLLL.LLLLLLLL
  LLL.L.LLLLLL.L.LL.LLLLLL.LLLLLL.LLLLLLLLLLL.LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLLLLLL.L
  LL.LL.L.LLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLL.LLLLLL.LLLLL.LLLL.LLLLLLLLL.L.LLLLLLLLLL.LLLLLLL.
  LLLLL.LLLL.LLLLLLLL.LL.L.LLLLLLLLLLLLLLL.LL.LLL.LLLLL.LLLL.LLLLLLLLL.LLLLLLL.LLLL.LL.LLLLL
  LL.........LLL..LL.L...L...L.....L...LL.....L..LLL........LL.L.LL.L......L...........L.LL.
  LLLLLLLLLLLLL.LLLLLLLL.LLLLLLLL.LLLLLLLL..LLLLL.LLLLL.LLLL.LLLLLLLLL.LLLLLLL.LLLL.LLLLLL.L
  LLLLLLLLLLLLLL.LLLLLLLL..LLLLLL.LLLLL.LL.LLLLL.LLLLLLLLLLL.LLLLLLLLL.LLLLLLL.LLLLLLLLLLLLL
  LLLL..LLL.LLLLLLLLLLLLLL.LLLLLL.LLLLLLLLLLLLLLL.LLLLL.LLLL.LLLLLLLLL.L.LLLLL.LLL..LLLLLLLL
  LLLLLLLLLLLL.L.LLLLLLLLL.LLLL.L.LL.LLLLL.LLLLLL.LLLLL.LLLLLLLLLLLLLL.LLLLLLL.LLLLLLLLLLLLL
  .LLLLLLLLLLLLL.LLLLLLLLL.LLLLLLLLLLLLLLL.L.LLLL.LLLLL.LLLL.LLLLL.LLLLLLLLLLLLLLLL.LLLLLLLL
  LLLLL.LL.LLLLL.LLLL.LLLL.LLL.LL.LLLLLLLLLLLLLLLLLLLLL.LLLL.LLLL.LLLL.LLLLLLL.LLLL.LLLLLLLL
  LLLLL.LLLLLLLLLLLLLLLLLL.LLLLLLLLLL.LL.L.LLLLLL.LL.LL.LLLL.LLLLLLLLLLLLLLLLL.LLLLL.LLLLLL.
  LLLLL.LLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLL.LLLLLL.L.LL...LLL.LLLLLL.LLLLLLLLLLLLLLLLLLLLLLLL
  ...LL....L.L.L........L.L..LL..LL.L..L...LLL..L.LL.LL.....L.....LL.L..LLL.LL.LL..LL...L...
  LLLLLLLLLLLLLL.LLLLLLLLL.LLL.LL.LLLLLLLL.LLLLLLLLLLLLLLLL..LLLLLLLLLLLLLLLL..LLLL.LLLLLLLL
  LLLLL..LLLLLLL.LLLLLLL.LL..LLLL.LLLLLLLLLLLL.LL.LLLLL.LLLL.LLLLLL.LLLLLLLLLL.LLLLLLLLLLLLL
  LLLLLLLLLLLLL.LLLLLLLLL..LLLLLL.LLLLLLLLLLLL.LL.LLLLLLLLLLLLLLLLLLLL.LLLLLLL.LLLL.LLLLLLLL
  LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLL.LLLLLLLL.LLLLLLLLLL.LLLLLLLLL.LLLLLLL.L.LL.LL.LLLLL
  LLLLL.LLLLL.LLLLLLLLLLLL.LLLL.L.LLLLLLLL.LLLLLL.LL.LL.LLLLLLLLLLLLL...LLLLLL.LLLLLLLLLLLLL
  LLLLLL.LLLLL.L.LLL.LLLLL.LLLL.L.LLLLL.LL.LLLLLL..LLLL.LLLLLLLLLLLLLLLLLLLLLL.LLLL.LLLLLLL.
  LLLLL.LLLLLLL..LLLLLLLLL..LLLLL.LLLLLLLLLLLLLLLLLLLLL.LLLL.LLLLLLLLL.LLLLLLL.L.LLLLLLLLLLL
  LLLLL.LLLLLLLL.LLLLLLLLL..LLLL..LLLLLLLL.LLLLLL.LL.LL.LLLLLL.LLLL.L..LLLLLLL.LL.L.LLLLLLLL
  .LL..L....L..LLL.L......LL..L.L.....LLL.....L.LLL.....L...L.......L...LLL...LL...L........
  LLLLLLLLLLLLLLLLLLL.LLLL.LLLLLL.LLLL.LLL.LLLLLL.LLLLL.LLLL.L.LLLLLLL.LLLLLLL.LLL..LLLLLLLL
  LLLLL.LLLL.LLL.LLLLLLLLL.LLLLLL.LLLLLLLL.LL.LLLLLLLLL.LLLL..LLL.LLLL.LLLLLLL.LLLL.LLLLLLLL
  LL.LL.LLLLLLLL.LLLLLLLLL.LLLLLL..LLLLL.L.LLLLLL..LLLL.LLLL.LL.LLLL.LLLLLLLLLLLLLL.LLLLLLL.
  LLLLL.LLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLLLLLLLLLLLLLLL.LL.L.LLLLLLLLLLLLLLLLL.LLLLLLLLLLLLL
  L...L.L....L..L...LLL.L..LLLLL.........LL.....LL...L....L..............L.L.L...LL.LL...LL.
  LLLLL.LLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLL...LLLLLLLLLLL.LLLL.LL.LLLLL..LLLLLLL.LLLL.LLLLLLLL
  LLLLL.LL.LLLLL.LLLLLLLLL.LLLLLL..LLLLLLLLLLL.LL.LLLLL.LLLL.LLLLLLLLLLLLLLLLL.LLLL.LL.LLLLL
  LLLLL.LLLLLLLL.LLLLLLLLL.LLLLLLLLLLLLLLL.LLLLLLLLL.LLLLLLL.LLLLLLLLLLLLLLLLLLLLLL.LLLLLLLL
  LLLLLLLLLL.LLL.LL.LLLLLL.LLLLLLLLLLLLLLL.L.LLLL.LLLLL.LLLL.LLLLLLLLLLLLLLLLL.LLLL.L.LLLLLL
  LLL.L.LLLLLLLL.LLLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLLLLLLL.LLLL.LLL.LLLL
  LLLLL.LLLLLLL..LLLLLLLLLLLLLLLL.LLLLLLLL.LLLLLL.LLLLL.LL.L.LLLLLLLLLLLLLL.LLLLLLLLLLLLLL.L
  ...LL.......LLLL.L..LL..L.LL.L.L..L.........L.L..LLL............L.L.LL..L.LL.L..LL........
  LLLLL.LLLLLLLL.LLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLL.LLLLL.LLLL.LLL.LLLLL.LLLLLLLLLLLL.LLLLLLLL
  L.LLLLLLLLL.LLLLLLLLLLLL.LLLLLL.LLLLLLLL.LLLLLLLLLLLL.LLLL.LLLLLLLLL.LLLLLLL.LLLLLLLLLLL.L
  LLLLL.LLLLLLLL.LLLL.LLLL.LLLLLL.LLLLLLLLLLLLLLL.LLLLLLLL.LLLLLLLLLLL.LLLLLLL.LLLL.LLLLLLLL
  LLLLL.LLLLLLLL.LLLLLL.LL.LLLLLL.LLLLLLLLLLLLLLL.LLLLL.LLLL.LLLLLLLLL.LLLLLLL.LLLL.LLLLLLLL
  LLLLL.LLLL.LLL..LLLLLLLLLLLLLLL.LLLLLLLL.LLLLLL.LLLL..LLLL.LLLLLLLLLLLLLLLLLLLLLL.LLLLLLLL
  LLLLL.LLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLLLLLLLLL.LLLLL.LLLL.L.LLLLLLLLL.LLLLL.LLLLLLLLLLL.L
  LLLLL.LLLLLLLLLLLLLLLLL..LLLLLLLLLLL.LLL.LLLLLL.LLL.LLLLLL.LLLLLLLLLL.LLLLLL.LLLL.LL.LLLLL
  ..L..L....LL.L............L....LL.........LLLL.L.L........L..L...LLL.....L.......LL..L..LL
  LLLLL.L.LLLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLLL.LLL.LLLLL.LLLL.LLLLLLLLL.LLLLLLL.LLLL.LLLLLLLL
  LLLLLLLLLLLL.LLLLLLLLL.L.LLLLLL.LLLLLLLL.L.LLLL.LLLLL.LLLL..LLLLLLLL.LLLLLLL.LLLLLLLLLLLLL
  LLLLLLLLLLLLLL.LLLLLLLL.LLLLLLLLLLLLLLLL.LLLLL..L.LLL..LLLLLLLLLLLLL.LLLLLLL.LLLL.LLLLLLLL
  LLLLL.LLLLLLLLLLLLLLLLLL.LLLLLL..LLLLLLLLLLLLLLLL.LLLLLLLL.LLLLLLLLL.L.LLLLLLLLLLLLLLLLLLL
  .L..L...L.....LL...........L.LL..LL...LL.LLL..........L.L.LL..L.LLL...L....LL.LL....LLL.LL
  LLLLL.L.LLLL.LLLLLLLLLLLLLLLLLL.LL.LLLLLLLLLLLLLLLLLLLLLLL.LLLLLLLLLLLLLL.LLLLLLLLLL.LLLLL
  LLLLL.LLLLLLLLLLL.L.LLLLLLLLLLLL.LLLLLLL.LLLLL..L.LLL.LLLLLLL.LLLLLL.LLLLLLL..LLL.LLLLLLL.
  LLLLLLLLLLLLLL.L.LLLLLLL.LLLLLLLLLL.LLLL.LLLLLL.LLLLL.LLLLLLLLLLLL.LLLLLLLLLLL.LLL.LLLLLLL
  LLLLL.LL.LLLLLLLLLLLLLLL.LLLLLL.LLLLL.LL.LLLLLL.LLLLL.LLLLLLLLLLLLLL.LLLLLLLLLLLL.LLLLLLLL
  LL..L.LLLLLLLL.LLLLLLL.L.LLLL.LLLLL.LLLLLLLLLLLL.LLL..LLLL.LLLLLLLL..LLLL.L..LLLLLLLLLLL.L
  LLLLLLLLLLLLLLLLLLLLLLLL.LLL.LL.LLLL.LLL.LLLLLL.LLLLL.LLLL.LLLLLLLLL.LLLLLLLLLLLL.LLLLLLLL
  LLLLLLLLLLLLLLLLLLLLLLLL.LLLL.L.LLLLLLLLLLLLLLL.L.LLLLLLLL..LLLLLLLL.LLLLLLLLLLLLLLLLLLLLL
  LLLLL.LLLLLLLL.L.LLLLLLL.LLLLLL..LLL.LLL.LLLLLL.LLLLL.LLLL.LLLLLLLLLLLLLLLLL.LLLLLLLLLLLLL
  .L.L.L.....LL.LL.LL...LL.L..LL........LL.......L..LLLL..L.L.LL....L...L....L.L.L...L..L...
  LLLLL..LLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLLLL.LLLL.LLLLLLLLLLLLLLLLLLL..LLLLLLL.LLLL.LLLLLLLL
  LLLLL.LLLL.LLL.LLLLLLLLL.LLLLLLLLLLLLLL..LLLLLLLLLLLL.LLLLLLLLLLLLLL.LLLLLLLLLLLL.LLL.LLLL
  .LLLLLLLLLLLLL..LLLLLLLLLLLLLLL.LLLLLLLL.LLLLLL.L.LLL.LLLLLLLLLLLLLLLLLLLLLL.LLLL.LLLLLLLL
  LLLLL.LLLLLLLL.LLLLLLLLL.LLLLL..LL.LLLL.LLLLLLL.LL.LL.LLLL.LLLLLLLLLLLLLL..L.L..L.LLLLLLLL
  LLLLLLLLLLLLLLLLL.LLLLLLLLLLLLL.LLLLL.L..LLLLLLLLLLLL.LLLL.LLLLLLLLL.LLLLLLL.LLLLLLLLLLLLL
  LLLLL.LLLL.LLLL.LLL.LLLL.LLLLLL.LLLLLLLL.LLLLLL.LLLLL.LLLLLLLLLLLLLL..LLLLLL.LLLLLLLLLLLLL
  LLLLLLLLLLLLLL..LLLL.LLL.LLLLLL.LLLLLLLL.LLLLLL.LLLLL..LLL.LLLLLLLLL.LLLLLLLLL.L..LLLLLLLL
  ..LLL..L..L.LL..LLL....L..L...L.L.L.L.L.L.L.LLL..LLL..L...L.......LLL..L.....LL...LL....L.
  LLLLL.LLLLLLLL.LLLLLLLLL.LLLLLLLLLLLL.LLLLL.LLLLLLLLL.LLLL.LLLLLLLLL.LLLL.LLLLLLL.LLLLLLLL
  LLLLL.LLLLLLLLLLLLLL.LLL.LLLLLL.LLLLLLLL.LLLLLLLLL.LL.LLLL.LLLLLLL.L.LLLLLLLLLLLL.LLLLLLLL
  LLLLL.LLLL.LLL.LLLLLLLLL.LLLLLLLLLLLLLLL..LLLLL.LLLLL.LLLL..LL..LLLL.LLLLLLL.LLLL.LLLLLLLL
  LLLLL.LLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLLL.LLLLLL.LLLLLLLLLL..LLLL.LL..LLLLLLL.LLLLLLLLLLLLL
  LLLLLLLLLLLLLL.LL.LLLLLL.LLLL.L..LLLLLLL.LLL.LL.LLLLLLLLLL.LLLLLLLLL.L.LLLLL.LLLL.LLLLLL.L
  """

  test "part 1, testset change_seats" do
    assert Day11.parse(@testset1) |> Day11.change_seats_adjacent() == Day11.parse(@testset2)
    # Day11.parse(@testset2) |> Enum.map(&IO.inspect/1)
    assert Day11.parse(@testset2) |> Day11.change_seats_adjacent() == Day11.parse(@testset3)
    assert Day11.parse(@testset3) |> Day11.change_seats_adjacent() == Day11.parse(@testset4)
    assert Day11.parse(@testset4) |> Day11.change_seats_adjacent() == Day11.parse(@testset5)
    assert Day11.parse(@testset5) |> Day11.change_seats_adjacent() == Day11.parse(@testset6)
  end

  test "part 1, testsets" do
    assert Day11.part1(@testset1) == 37
  end

  test "part 1, input" do
    assert Day11.part1(@input) == 2093
  end

  @testset_seeing1 """
  L.LL.LL.LL
  LLLLLLL.LL
  L.L.L..L..
  LLLL.LL.LL
  L.LL.LL.LL
  L.LLLLL.LL
  ..L.L.....
  LLLLLLLLLL
  L.LLLLLL.L
  L.LLLLL.LL
  """

  @testset_seeing2 """
  #.##.##.##
  #######.##
  #.#.#..#..
  ####.##.##
  #.##.##.##
  #.#####.##
  ..#.#.....
  ##########
  #.######.#
  #.#####.##
  """

  @testset_seeing3 """
  #.LL.LL.L#
  #LLLLLL.LL
  L.L.L..L..
  LLLL.LL.LL
  L.LL.LL.LL
  L.LLLLL.LL
  ..L.L.....
  LLLLLLLLL#
  #.LLLLLL.L
  #.LLLLL.L#
  """

  @testset_seeing4 """
  #.L#.##.L#
  #L#####.LL
  L.#.#..#..
  ##L#.##.##
  #.##.#L.##
  #.#####.#L
  ..#.#.....
  LLL####LL#
  #.L#####.L
  #.L####.L#
  """

  @testset_seeing5 """
  #.L#.L#.L#
  #LLLLLL.LL
  L.L.L..#..
  ##LL.LL.L#
  L.LL.LL.L#
  #.LLLLL.LL
  ..L.L.....
  LLLLLLLLL#
  #.LLLLL#.L
  #.L#LL#.L#
  """

  @testset_seeing6 """
  #.L#.L#.L#
  #LLLLLL.LL
  L.L.L..#..
  ##L#.#L.L#
  L.L#.#L.L#
  #.L####.LL
  ..#.#.....
  LLL###LLL#
  #.LLLLL#.L
  #.L#LL#.L#
  """

  @testset_seeing7 """
  #.L#.L#.L#
  #LLLLLL.LL
  L.L.L..#..
  ##L#.#L.L#
  L.L#.LL.L#
  #.LLLL#.LL
  ..#.L.....
  LLL###LLL#
  #.LLLLL#.L
  #.L#LL#.L#
  """

  test "part 2, testset change_seats" do
    assert Day11.parse(@testset_seeing1) |> Day11.change_seats_seeing() ==
             Day11.parse(@testset_seeing2)

    # Day11.parse(@testset2) |>_seeing Enum.map(&IO.inspect/1)
    assert Day11.parse(@testset_seeing2) |> Day11.change_seats_seeing() ==
             Day11.parse(@testset_seeing3)

    assert Day11.parse(@testset_seeing3) |> Day11.change_seats_seeing() ==
             Day11.parse(@testset_seeing4)

    assert Day11.parse(@testset_seeing4) |> Day11.change_seats_seeing() ==
             Day11.parse(@testset_seeing5)

    assert Day11.parse(@testset_seeing5) |> Day11.change_seats_seeing() ==
             Day11.parse(@testset_seeing6)

    assert Day11.parse(@testset_seeing6) |> Day11.change_seats_seeing() ==
             Day11.parse(@testset_seeing7)
  end

  test "part 2, testset seeing" do
    assert Day11.part2(@testset_seeing1) == 26
  end

  test "part 2, input" do
    assert Day11.part2(@input) == 1862
  end
end
