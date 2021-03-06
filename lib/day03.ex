defmodule AOC.Day03 do
  @moduledoc false

  def part1(input) do
    {width, trees} = input |> parse_trees()

    trees
    |> traverse_map({3, 1}, width)
    |> length()
  end

  def part2(input) do
    {width, trees} = input |> parse_trees()

    [{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}]
    |> Enum.map(fn pos -> traverse_map(trees, pos, width) |> length() end)
    |> Enum.reduce(fn x, acc -> x * acc end)
  end

  def parse_trees(input) do
    lines = input |> String.split("\n", trim: true)
    width = lines |> hd |> String.length()

    {width,
     lines
     |> Enum.with_index()
     |> Enum.flat_map(&parse_tree_line/1)}
  end

  def parse_tree_line({line, y}) do
    line
    |> String.to_charlist()
    |> Enum.with_index()
    |> Enum.reduce([], fn
      {?#, x}, acc -> [{y, x} | acc]
      _, acc -> acc
    end)
    |> Enum.reverse()
  end

  def traverse_map(map, {slope_x, slope_y}, width) do
    height = length(map)

    {height, width, slope_x, slope_y}
    |> generate_path()
    |> Enum.filter(fn pos -> pos in map end)
  end

  # def generate_path(height, width, slope_x, slope_y) when slope_x > slope_y,
  #   do: 0..(height - 1) |> Enum.map(fn y -> {y, rem(y * slope_x, width)} end)

  def generate_path(params),
    do: generate_path(params, [], 0, 0)

  def generate_path({height, _, _, _}, path, _, y) when y >= height,
    do: path

  def generate_path(params, path, x, y) do
    {_height, width, slope_x, slope_y} = params
    path = [{y, rem(x, width)} | path]
    generate_path(params, path, x + slope_x, y + slope_y)
  end
end
