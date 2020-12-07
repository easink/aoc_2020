defmodule AOC.Day07 do
  @moduledoc false

  @shiny_gold "shiny gold"

  def part1(input) do
    input
    |> parse_rules()
    |> find_bags()
  end

  def part2(input) do
    input
    |> parse_rules()
    |> traverse_bag(@shiny_gold)
  end

  def traverse_bag(bags, bag) do
    Enum.reduce(bags[bag], 0, fn
      {b, n}, acc -> acc + n + n * traverse_bag(bags, b)
    end)
  end

  def find_bags(rules) do
    rules
    |> Enum.filter(fn {bag, _bags} -> find_golden_bag(bag, rules) end)
    |> Enum.map(fn {bag, _bags} -> bag end)
    |> Enum.filter(fn bag -> bag != @shiny_gold end)
  end

  def find_golden_bag(@shiny_gold, _bags), do: true

  def find_golden_bag(bag, bags) do
    for({b, _n} <- bags[bag], do: b)
    |> Enum.find(fn b -> find_golden_bag(b, bags) end)
  end

  def parse_rules(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
    |> Enum.into(%{})
  end

  def parse_line(line) do
    [bag, contains] = String.split(line, " bags contain ")
    {bag, parse_contains(contains)}
  end

  def parse_contains(contains) do
    contains
    |> String.split(~r/ bags?[,.] ?/, trim: true)
    |> Enum.map(&String.split(&1, " ", parts: 2))
    |> parse_bags()
  end

  def parse_bags(contains), do: parse_bags(contains, %{})
  def parse_bags([], bags), do: bags
  def parse_bags([["no", "other"] | _contains], bags), do: bags

  def parse_bags([[n, bag] | contains], bags) do
    bags = Map.put(bags, bag, String.to_integer(n))
    parse_bags(contains, bags)
  end
end
