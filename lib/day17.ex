defmodule AOC.Day17 do
  @moduledoc false

  def part1(input) do
    input
    |> parse()
    |> simulate(&inactive_cube/1, 6)
    |> length()
  end

  def part2(input) do
    input
    |> parse()
    |> add_w()
    |> simulate(&inactive_hypercube/1, 6)
    |> length()
  end

  def parse(input, z \\ 0) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&Enum.with_index/1)
    |> Enum.map(&Enum.filter(&1, fn {x, _} -> x == "#" end))
    |> Enum.map(&Enum.map(&1, fn {_, x} -> x end))
    |> Enum.with_index()
    |> Enum.map(fn {xs, y} -> Enum.reduce(xs, [], fn x, acc -> [{x, y, z} | acc] end) end)
    |> List.flatten()
  end

  def add_w(cube), do: Enum.map(cube, fn {x, y, z} -> {x, y, z, 0} end)

  def inactive_cube(cube) do
    {min_x, max_x, min_y, max_y, min_z, max_z} =
      Enum.reduce(cube, {0, 0, 0, 0, 0, 0}, fn
        {x, y, z}, {min_x, max_x, min_y, max_y, min_z, max_z} ->
          {
            min(x, min_x),
            max(x, max_x),
            min(y, min_y),
            max(y, max_y),
            min(z, min_z),
            max(z, max_z)
          }
      end)

    for z <- (min_z - 1)..(max_z + 1),
        y <- (min_y - 1)..(max_y + 1),
        x <- (min_x - 1)..(max_x + 1),
        {x, y, z} not in cube,
        do: {x, y, z}
  end

  def inactive_hypercube(cube) do
    {min_x, max_x, min_y, max_y, min_z, max_z, min_w, max_w} =
      Enum.reduce(cube, {0, 0, 0, 0, 0, 0, 0, 0}, fn
        {x, y, z, w}, {min_x, max_x, min_y, max_y, min_z, max_z, min_w, max_w} ->
          {
            min(x, min_x),
            max(x, max_x),
            min(y, min_y),
            max(y, max_y),
            min(z, min_z),
            max(z, max_z),
            min(w, min_w),
            max(w, max_w)
          }
      end)

    for w <- (min_w - 1)..(max_w + 1),
        z <- (min_z - 1)..(max_z + 1),
        y <- (min_y - 1)..(max_y + 1),
        x <- (min_x - 1)..(max_x + 1),
        {x, y, z, w} not in cube,
        do: {x, y, z, w}
  end

  def simulate(cube, _fun, 0), do: cube

  def simulate(cube, inactive_cube_fun, cycles) do
    still_active_cells =
      Enum.reduce(cube, [], fn cell, active_cells ->
        case active_neighbours(cube, cell) do
          2 -> [cell | active_cells]
          3 -> [cell | active_cells]
          _ -> active_cells
        end
      end)

    inactive_cube = inactive_cube_fun.(cube)

    active_cells_from_inactive =
      Enum.reduce(inactive_cube, [], fn cell, active_cells ->
        case active_neighbours(cube, cell) do
          3 -> [cell | active_cells]
          _ -> active_cells
        end
      end)

    new_cube = active_cells_from_inactive ++ still_active_cells
    simulate(new_cube, inactive_cube_fun, cycles - 1)
  end

  def active_neighbours(cube, cell) do
    cell
    |> neighbours()
    |> disjoint(cube)
    |> length()
  end

  def neighbours({pos_x, pos_y, pos_z}) do
    for z <- (pos_z - 1)..(pos_z + 1),
        y <- (pos_y - 1)..(pos_y + 1),
        x <- (pos_x - 1)..(pos_x + 1),
        {x, y, z} != {pos_x, pos_y, pos_z},
        do: {x, y, z}
  end

  def neighbours({pos_x, pos_y, pos_z, pos_w}) do
    for w <- (pos_w - 1)..(pos_w + 1),
        z <- (pos_z - 1)..(pos_z + 1),
        y <- (pos_y - 1)..(pos_y + 1),
        x <- (pos_x - 1)..(pos_x + 1),
        {x, y, z, w} != {pos_x, pos_y, pos_z, pos_w},
        do: {x, y, z, w}
  end

  def disjoint(cube, cube2),
    do: cube -- cube -- cube2
end
