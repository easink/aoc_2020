defmodule AOC.Day12 do
  @moduledoc false

  def part1(input) do
    input
    |> parse()
    |> walk()
  end

  def part2(input) do
    input
    |> parse()
    |> walk_with_waypoint()
  end

  def parse(input) do
    input
    |> String.split(" ")
    |> Enum.map(fn <<dir>> <> val -> {<<dir>>, String.to_integer(val)} end)
  end

  def walk_with_waypoint(path), do: walk_with_waypoint(path, {0, 0}, {10, 1})

  def walk_with_waypoint([], {x, y}, _waypoint), do: abs(x) + abs(y)

  def walk_with_waypoint([{instruction, value} | path], pos, waypoint) do
    case instruction do
      "L" ->
        updated_waypoint = rotate_waypoint_left(value, waypoint)
        walk_with_waypoint(path, pos, updated_waypoint)

      "R" ->
        updated_waypoint = rotate_waypoint_right(value, waypoint)
        walk_with_waypoint(path, pos, updated_waypoint)

      "F" ->
        {x, y} = pos
        {waypoint_x, waypoint_y} = waypoint
        updated_pos = {x + value * waypoint_x, y + value * waypoint_y}
        walk_with_waypoint(path, updated_pos, waypoint)

      _ ->
        updated_waypoint = move(instruction, value, waypoint)
        walk_with_waypoint(path, pos, updated_waypoint)
    end
  end

  def walk(path), do: walk(path, "E", {0, 0})

  def walk([], _direction, {x, y}), do: abs(x) + abs(y)

  def walk([{instruction, value} | path], direction, pos) do
    case instruction do
      "L" ->
        direction = rotate_left(value, direction)
        walk(path, direction, pos)

      "R" ->
        updated_direction = rotate_right(value, direction)
        walk(path, updated_direction, pos)

      "F" ->
        updated_pos = move(direction, value, pos)
        walk(path, direction, updated_pos)

      _ ->
        updated_pos = move(instruction, value, pos)
        walk(path, direction, updated_pos)
    end
  end

  def rotate_waypoint_left(angle, waypoint),
    do: rotate_waypoint_steps(waypoint, 4 - div(angle, 90))

  def rotate_waypoint_right(angle, waypoint),
    do: rotate_waypoint_steps(waypoint, div(angle, 90))

  def rotate_left(angle, direction), do: rotate_steps(direction, 4 - div(angle, 90))
  def rotate_right(angle, direction), do: rotate_steps(direction, div(angle, 90))

  def rotate_waypoint_steps(waypoint, 0), do: waypoint

  def rotate_waypoint_steps(waypoint, n) do
    updated_waypoint = rotate_waypoint_step(waypoint)
    rotate_waypoint_steps(updated_waypoint, n - 1)
  end

  def rotate_waypoint_step({x, y}), do: {y, -x}

  def rotate_steps(direction, steps) do
    {_direction, index} =
      directions()
      |> Enum.with_index()
      |> List.keyfind(direction, 0)

    directions() |> Enum.at(rem(index + steps, 4))
  end

  def move("E", value, {x, y}), do: {x + value, y}
  def move("S", value, {x, y}), do: {x, y - value}
  def move("W", value, {x, y}), do: {x - value, y}
  def move("N", value, {x, y}), do: {x, y + value}

  def directions(), do: ["E", "S", "W", "N"]
end
