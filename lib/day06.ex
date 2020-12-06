defmodule AOC.Day06 do
  @moduledoc false

  def part1(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(&count/1)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(&count_equals/1)
    |> Enum.sum()
  end

  def count(group) do
    group
    |> String.replace("\n", "")
    |> String.to_charlist()
    |> Enum.uniq()
    |> length()
  end

  def count_equals(group) do
    group
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_charlist/1)
    |> equals()
    |> length()
  end

  def equal(a1, a2), do: a1 -- a1 -- a2

  def equals(answers), do: equals(answers, hd(answers))
  def equals([a1 | []], answer), do: equal(a1, answer)
  def equals([a1 | answers], answer), do: equals(answers, equal(a1, answer))
end
