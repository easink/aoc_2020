defmodule AOC.Day23 do
  @moduledoc false

  def part1(input, n) do
    input
    |> parse()
    |> circle()
    |> move(n)
    |> after_1()
    |> print()
  end

  def part2(input, n) do
    (parse(input) ++ for(x <- 10..1_000_000, do: x))
    |> circle()
    |> move(n)
    |> two_after_1()
  end

  def move(cups, n) do
    current = Map.get(cups, :first)
    move(cups, current, n)
  end

  def move(cups, _current, 0), do: cups

  def move(cups, current, n) do
    a = Map.get(cups, current)
    b = Map.get(cups, a)
    c = Map.get(cups, b)

    picked = [a, b, c]
    destination = destination_cup(cups, picked, current - 1)

    updated_cups = move_picked(cups, picked, destination, current)
    next = Map.get(updated_cups, current)
    move(updated_cups, next, n - 1)
  end

  def destination_cup(cups, picked, destination) do
    cond do
      destination in picked ->
        destination_cup(cups, picked, destination - 1)

      destination < 1 ->
        max = Map.get(cups, :max)
        destination_cup(cups, picked, max)

      true ->
        destination
    end
  end

  def move_picked(cups, [a, _b, c], destination, current) do
    next = Map.get(cups, c)
    dest_neighbour = Map.get(cups, destination)

    cups
    |> Map.put(current, next)
    |> Map.put(destination, a)
    |> Map.put(c, dest_neighbour)
  end

  def parse(input), do: Enum.map(input, fn c -> c - ?0 end)
  def print(list), do: Enum.map(list, fn x -> x + ?0 end)

  def circle(list) do
    max = Enum.max(list)
    [first | list] = list

    list
    |> circle(first, first, %{})
    |> Map.put(:max, max)
    |> Map.put(:first, first)
  end

  def circle([], prev, first, circle) do
    Map.put(circle, prev, first)
  end

  def circle([next | list], prev, first, circle) do
    circle = Map.put(circle, prev, next)
    circle(list, next, first, circle)
  end

  def after_1(cups) do
    next = Map.get(cups, 1)
    after_1(cups, next, [])
  end

  def after_1(_cups, 1, order), do: Enum.reverse(order)

  def after_1(cups, prev, order) do
    next = Map.get(cups, prev)
    after_1(cups, next, [prev | order])
  end

  def two_after_1(cups) do
    a = Map.get(cups, 1)
    b = Map.get(cups, a)
    a * b
  end
end
