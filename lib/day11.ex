defmodule AOC.Day11 do
  @moduledoc false

  def part1(input) do
    input
    |> parse()
    |> while_change_seats_adjacent()
    |> count_occupied()
  end

  def part2(input) do
    input
    |> parse()
    |> while_change_seats_seeing()
    |> count_occupied()
  end

  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_charlist/1)
  end

  def to_tuple(list_of_lists) do
    list_of_lists
    |> Enum.map(&List.to_tuple/1)
    |> List.to_tuple()
  end

  def count_occupied(seats) do
    seats
    |> Enum.join()
    |> String.to_charlist()
    |> Enum.count(fn x -> x == ?# end)
  end

  def size(seats) do
    {tuple_size(seats) - 1, tuple_size(elem(seats, 0)) - 1}
  end

  def while_change_seats_adjacent(seats) do
    updated_seats = change_seats_adjacent(seats)

    if updated_seats == seats,
      do: seats,
      else: while_change_seats_adjacent(updated_seats)
  end

  def while_change_seats_seeing(seats) do
    updated_seats = change_seats_seeing(seats)

    if updated_seats == seats,
      do: seats,
      else: while_change_seats_seeing(updated_seats)
  end

  def change_seats_adjacent(seats) do
    seats = seats |> to_tuple()
    {max_y, max_x} = size(seats)

    for y <- 0..max_y, x <- 0..max_x do
      change_seat_adjacent(seats, {max_y, max_x}, {y, x})
    end
    |> Enum.chunk_every(max_x + 1)
  end

  def change_seats_seeing(seats) do
    seats = seats |> to_tuple()
    {max_y, max_x} = size(seats)

    for y <- 0..max_y, x <- 0..max_x do
      change_seat_seeing(seats, {max_y, max_x}, {y, x})
    end
    |> Enum.chunk_every(max_x + 1)
  end

  def get_seat(seats, {max_y, max_x}, {y, x}) do
    cond do
      x > max_x or x < 0 ->
        nil

      y > max_y or y < 0 ->
        nil

      true ->
        line = elem(seats, y)
        _val = elem(line, x)
    end
  end

  def directions() do
    for(dy <- -1..1, dx <- -1..1, do: {dy, dx})
    |> List.delete({0, 0})
  end

  def get_seeing_seats(seats, size, pos) do
    directions()
    |> Enum.map(fn delta ->
      get_seeing_seats(seats, size, pos, delta, 0, [])
    end)
  end

  def get_adjacent_seats(seats, size, pos) do
    directions()
    |> Enum.map(fn delta ->
      get_adjacent_seats(seats, size, pos, delta, [])
    end)
  end

  def get_seeing_seats(seats, size, {y, x}, {dy, dx} = delta, n, acc) do
    new_pos = {y + dy, x + dx}

    case get_seat(seats, size, new_pos) do
      nil -> acc
      ?. -> get_seeing_seats(seats, size, new_pos, delta, n + 1, acc)
      free_or_occupied -> [free_or_occupied | acc]
    end
  end

  def get_adjacent_seats(seats, size, {y, x}, {dy, dx}, acc) do
    new_pos = {y + dy, x + dx}

    case get_seat(seats, size, new_pos) do
      nil -> acc
      val -> [val | acc]
    end
  end

  def change_seat_adjacent(seats, size, pos) do
    case get_seat(seats, size, pos) do
      ?# ->
        adjacents = get_adjacent_seats(seats, size, pos)
        occupied = Enum.count(adjacents, fn x -> x == '#' end)
        if occupied >= 4, do: ?L, else: ?#

      ?L ->
        adjacents = get_adjacent_seats(seats, size, pos)
        occupied = Enum.count(adjacents, fn x -> x == '#' end)
        if occupied == 0, do: ?#, else: ?L

      seat ->
        seat
    end
  end

  def change_seat_seeing(seats, size, pos) do
    case get_seat(seats, size, pos) do
      ?# ->
        seeing = get_seeing_seats(seats, size, pos)
        occupied = Enum.count(seeing, fn x -> x == '#' end)
        if occupied >= 5, do: ?L, else: ?#

      ?L ->
        seeing = get_seeing_seats(seats, size, pos)
        occupied = Enum.count(seeing, fn x -> x == '#' end)
        if occupied == 0, do: ?#, else: ?L

      seat ->
        seat
    end
  end
end
