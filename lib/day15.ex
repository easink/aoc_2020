defmodule AOC.Day15 do
  @moduledoc false

  def part1(input) do
    {memory, pos, last} = prep(input)
    iterate(memory, pos, last, 2020)
  end

  def part2(input) do
    {memory, pos, last} = prep(input)
    iterate(memory, pos, last, 30_000_000)
  end

  def prep(input) do
    all_but_last = Enum.take(input, length(input) - 1)
    memory = all_but_last |> Enum.with_index() |> Enum.into(%{})
    pos = length(all_but_last)
    last = List.last(input)
    {memory, pos, last}
  end

  def iterate(_memory, pos, last, iters) when pos == iters - 1, do: last

  def iterate(memory, pos, last, iters) do
    updated_memory = Map.put(memory, last, pos)

    updated_last =
      case Map.get(memory, last) do
        nil -> 0
        old_pos -> pos - old_pos
      end

    iterate(updated_memory, pos + 1, updated_last, iters)
  end
end
