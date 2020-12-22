defmodule AOC.Day16 do
  @moduledoc false

  def part1(input) do
    {rules, _ticket, nearby} = input |> parse()

    nearby
    |> List.flatten()
    |> Enum.reject(fn value -> match_any_rule?(value, rules) end)
    |> Enum.sum()
  end

  def sub_part2(input) do
    {rules, ticket, nearby} = input |> parse()

    nearby
    |> reject_tickets(rules)
    |> parse_nearby()
    |> columns_match_rule(rules)
    |> classify_columns(%{})
    |> ticket_departures(ticket)
  end

  def part2(input) do
    input
    |> parse()
  end

  def parse(input) do
    [rules, ticket, nearby] = String.split(input, "\n\n")

    rules = parse_rules(rules)
    [ticket] = parse_tickets(ticket)
    nearby = parse_tickets(nearby)

    {rules, ticket, nearby}
  end

  def parse_rules(rules) do
    rules
    |> String.split("\n", trim: true)
    |> Enum.reduce(%{}, fn line, rules -> parse_rule_line(line, rules) end)
  end

  def parse_rule_line(rule_line, rules) do
    [type, ranges] = String.split(rule_line, ": ")
    Map.put(rules, type, parse_ranges(ranges))
  end

  def parse_ranges(line) do
    line
    |> String.split(" or ")
    |> Enum.map(&String.split(&1, "-"))
    |> Enum.map(fn [a, b] -> Range.new(String.to_integer(a), String.to_integer(b)) end)
  end

  def parse_tickets(tickets) do
    tickets
    |> String.split("\n", trim: true)
    |> Enum.drop(1)
    |> Enum.map(&parse_ticket/1)
  end

  def parse_ticket(ticket) do
    ticket
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  def parse_nearby(nearby) do
    nearby
    |> Enum.map(&Enum.with_index/1)
    |> List.flatten()
    |> Enum.reduce(%{}, fn {val, col}, acc ->
      Map.update(acc, col, [val], fn list -> [val | list] end)
    end)
  end

  def match_any_rule?(value, rules) do
    rules
    |> Map.values()
    |> List.flatten()
    |> Enum.any?(fn rule -> value in rule end)
  end

  def all_values_match_rule?(values, rule_criterias) do
    values
    |> Enum.all?(fn value ->
      rule_criterias
      |> Enum.any?(fn rule_criteria ->
        value in rule_criteria
      end)
    end)
  end

  def reject_tickets(tickets, rules) do
    Enum.filter(tickets, fn values ->
      Enum.all?(values, fn value -> match_any_rule?(value, rules) end)
    end)
  end

  def columns_match_rule(columns, rules) do
    rules
    |> Map.keys()
    |> Enum.map(fn rule ->
      rule_criterias = Map.get(rules, rule)

      matched_columns =
        columns
        |> Map.keys()
        |> Enum.filter(fn column ->
          columns
          |> Map.get(column)
          |> all_values_match_rule?(rule_criterias)
        end)

      {rule, matched_columns}
    end)
  end

  def classify_columns([], acc), do: acc

  def classify_columns(column_rules, acc) do
    {rule_name, [column]} =
      column_rule =
      Enum.find(column_rules, fn {_rule_name, columns} ->
        length(columns) == 1
      end)

    acc = acc |> Map.put(rule_name, column)

    (column_rules -- [column_rule])
    |> Enum.map(fn {rule_name, columns} -> {rule_name, columns -- [column]} end)
    |> classify_columns(acc)
  end

  def ticket_departures(column_rules, ticket) do
    Enum.reduce(column_rules, 1, fn
      {"departure" <> _, column}, acc -> acc * Enum.at(ticket, column)
      _ignore, acc -> acc
    end)
  end
end
