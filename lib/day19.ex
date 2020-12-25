defmodule AOC.Day19 do
  @moduledoc false

  @valid_chars [?a, ?b]

  def part1(input) do
    input
    |> parse()
    |> matching_messages()
  end

  def part2(input) do
    input
    |> parse()
    |> update_rules()
    |> matching_messages()
  end

  def update_rules({rules, messages}) do
    updated_rules =
      rules
      |> Map.put(8, [[42], [42, 8]])
      |> Map.put(11, [[42, 31], [42, 11, 31]])

    {updated_rules, messages}
  end

  def matching_messages({rules, messages}) do
    messages
    |> Enum.filter(fn message -> pattern_match?(rules, message) end)
    |> length()
  end

  def pattern_match?(rules, message) do
    pattern_match(rules, [0], message) == {true, []}
  end

  def pattern_match(_rules, [], message), do: {true, message}
  def pattern_match(_rules, _pattern, []), do: false

  def pattern_match(rules, [rule_or_char | pattern], message) do
    case rule_or_char do
      <<char>> when char == hd(message) ->
        pattern_match(rules, pattern, tl(message))

      <<char>> when char in @valid_chars ->
        false

      rule ->
        rules
        |> Map.get(rule)
        |> Enum.reduce_while(false, fn patt, _acc ->
          case pattern_match(rules, patt ++ pattern, message) do
            {true, updated_message} -> {:halt, {true, updated_message}}
            false -> {:cont, false}
          end
        end)
    end
  end

  def parse(input) do
    [rules, messages] = input |> String.split("\n\n")

    rules =
      rules
      |> String.split("\n", trim: true)
      |> Enum.map(&parse_rule/1)
      |> Enum.into(%{})

    messages =
      messages
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_charlist/1)

    {rules, messages}
  end

  def parse_rule(rule) do
    [rule_idx, rule] = String.split(rule, ": ")
    rule_idx = String.to_integer(rule_idx)

    rule =
      rule
      |> String.split(" | ")
      |> Enum.map(&String.split(&1, " "))
      |> Enum.map(fn x ->
        Enum.map(x, fn c ->
          case c do
            <<?", a, ?">> -> <<a>>
            c -> String.to_integer(c)
          end
        end)
      end)

    {rule_idx, rule}
  end
end
