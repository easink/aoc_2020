defmodule AOC.Day08 do
  @moduledoc false

  def part1(input) do
    input
    |> parse_opcodes()
    |> execute()
  end

  def part2(input) do
    input
    |> parse_opcodes()
    |> opcodes_changer()
    |> find_done()
  end

  def parse_opcodes(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, " "))
    |> Enum.with_index()
    |> Enum.map(fn {[inst, val], addr} -> {addr, {inst, String.to_integer(val)}} end)
    |> Enum.into(%{})
  end

  def opcodes_changer(opcodes) do
    for ip <- 0..(map_size(opcodes) - 1), do: opcode_change(opcodes, ip)
  end

  def opcode_change(opcodes, ip) do
    case opcodes[ip] do
      {"jmp", val} -> Map.replace!(opcodes, ip, {"nop", val})
      {"nop", val} -> Map.replace!(opcodes, ip, {"jmp", val})
      _ -> opcodes
    end
  end

  def find_done(opcodes_list) do
    Enum.find_value(opcodes_list, fn opcodes ->
      case execute(opcodes) do
        {:done, val} -> {:done, val}
        _ -> false
      end
    end)
  end

  def execute(opcodes), do: execute(opcodes, 0, 0, [])

  def execute(opcodes, acc, ip, addresses) do
    cond do
      ip in addresses ->
        {:loop, acc}

      ip == map_size(opcodes) ->
        {:done, acc}

      true ->
        {new_acc, new_ip} = execute(opcodes[ip], acc, ip)
        execute(opcodes, new_acc, new_ip, [ip | addresses])
    end
  end

  def execute({"nop", _vl}, acc, ip), do: {acc, ip + 1}
  def execute({"acc", val}, acc, ip), do: {acc + val, ip + 1}
  def execute({"jmp", val}, acc, ip), do: {acc, ip + val}
end
