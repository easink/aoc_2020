defmodule AOC.Day01 do
  @moduledoc false

  def part1(input) do
    [a, b] = find_sum_to_2020(input, 0)
    IO.puts(inspect([a, b]))
    a * b
  end

  def part2(input) do
    [a, b, c] = find_three_to_2020(input)
    IO.puts(inspect([a, b, c]))
    a * b * c
  end

  def find_sum_to_2020([], _start), do: nil

  def find_sum_to_2020([value | list], start) do
    case Enum.find(list, fn x -> start + x + value == 2020 end) do
      nil -> find_sum_to_2020(list, start)
      y -> [value, y]
    end
  end

  def find_three_to_2020([value | list]) do
    case find_sum_to_2020(list, value) do
      nil -> find_three_to_2020(list)
      [a, b] -> [a, b, value]
    end
  end
end
