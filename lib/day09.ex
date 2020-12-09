defmodule AOC.Day09 do
  @moduledoc false

  def part1(input, preamble_size) do
    input
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> find_invalid(preamble_size)
  end

  def part2(input, invalid) do
    input
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> find_min_max(invalid)
  end

  def find_min_max([], _invalid), do: nil

  def find_min_max([head | rest] = list, invalid) do
    case find_min_max(list, head, head, 0, invalid) do
      {min, max} -> min + max
      nil -> find_min_max(rest, invalid)
    end
  end

  def find_min_max([_head | []], _min, _max, _sum, _invalid), do: nil

  def find_min_max([head | rest], min, max, sum, invalid) do
    min = min(head, min)
    max = max(head, max)
    sum = head + sum

    cond do
      sum == invalid -> {min, max}
      sum > invalid -> nil
      true -> find_min_max(rest, min, max, sum, invalid)
    end
  end

  def find_invalid([_head | rest] = list, preamble_size) do
    {preamble, [head | _rest]} = Enum.split(list, preamble_size)

    if head in sum_gen(preamble),
      do: find_invalid(rest, preamble_size),
      else: head
  end

  def sum_gen(preamble), do: sum_gen(preamble, [])
  def sum_gen([], sums), do: sums

  def sum_gen([head | preamble], sums),
    do: sum_gen(preamble, sums ++ Enum.map(preamble, &(head + &1)))
end
