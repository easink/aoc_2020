defmodule AOC.Day02 do
  @moduledoc false

  def part1(input) do
    input
    |> parse()
    |> Enum.count(&valid_password/1)
  end

  def part2(input) do
    input
    |> parse()
    |> Enum.count(&valid_password_pos/1)
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ": "))
    |> Enum.map(fn [rule, password] ->
      [min, max, char] = rule |> String.split(~r{[- ]})

      {
        char |> String.to_charlist() |> hd,
        min |> String.to_integer(),
        max |> String.to_integer(),
        password |> String.to_charlist()
      }
    end)
  end

  defp valid_password({char, min, max, password}) do
    nchars = Enum.count(password, &(char == &1))
    min <= nchars and nchars <= max
  end

  defp valid_password_pos({char, pos1, pos2, password}) do
    p = Enum.at(password, pos1 - 1) == char
    q = Enum.at(password, pos2 - 1) == char
    (p or q) and not (p and q)
  end
end
