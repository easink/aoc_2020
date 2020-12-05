defmodule AOC.Day05 do
  @moduledoc false

  def part1(input) do
    input
    |> Enum.map(&parse/1)
    |> Enum.max_by(fn {_row, _col, seat_id} -> seat_id end)
  end

  def part2(input) do
    seats = Enum.map(input, &parse/1)

    seats
    |> all_seats()
    |> Enum.filter(fn x -> x not in seats end)
  end

  def parse(<<r1, r2, r3, r4, r5, r6, r7, c1, c2, c3>>) do
    <<row>> = <<
      char_to_bin(r1)::2,
      char_to_bin(r2)::1,
      char_to_bin(r3)::1,
      char_to_bin(r4)::1,
      char_to_bin(r5)::1,
      char_to_bin(r6)::1,
      char_to_bin(r7)::1
    >>

    <<col>> = <<
      char_to_bin(c1)::6,
      char_to_bin(c2)::1,
      char_to_bin(c3)::1
    >>

    {row, col, row * 8 + col}
  end

  def all_seats(seats) do
    rows = Enum.map(seats, fn {row, _, _} -> row end)
    {low_row, high_row} = {Enum.min(rows) + 1, Enum.max(rows) - 1}
    for row <- low_row..high_row, col <- 0..7, do: {row, col, row * 8 + col}
  end

  defp char_to_bin(?F), do: 0
  defp char_to_bin(?B), do: 1
  defp char_to_bin(?L), do: 0
  defp char_to_bin(?R), do: 1
end
