defmodule AOC.Day10 do
  @moduledoc false

  def part1(input) do
    input
    |> parse()
    |> get_diffs()
    |> Enum.frequencies()
  end

  def part2(input) do
    input
    |> parse()
    |> get_diffs()
    |> get_paths()
  end

  def parse(input) do
    input
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
  end

  def get_diffs(values) do
    values
    |> Enum.sort()
    |> get_diffs(0, [])
    |> diff_finish()
  end

  def diff_finish(values), do: [3 | values] |> Enum.reverse()

  def get_diffs([], _prev, diffs), do: diffs

  def get_diffs([head | rest], prev, diffs),
    do: get_diffs(rest, head, [head - prev | diffs])

  def get_paths(diffs) do
    diffs
    |> Enum.chunk_by(&(&1 == 3))
    |> Enum.map(&paths/1)
    |> Enum.reduce(fn val, acc -> val * acc end)
  end

  def paths(start), do: paths(start, 0)

  def paths([a, b, c | rest], acc) when a + b + c == 3 do
    paths([b, c | rest], acc + 1) +
      paths([c | rest], acc + 1) +
      paths(rest, acc + 1)
  end

  def paths([a, b | rest], acc) when a + b <= 3 do
    paths([b | rest], acc + 1) + paths(rest, acc + 1)
  end

  def paths([], _acc), do: 1
  def paths([_ | _rest], _acc), do: 1
end
