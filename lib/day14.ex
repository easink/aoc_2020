defmodule AOC.Day14 do
  @moduledoc false

  use Bitwise

  def part1(input) do
    input
    |> parse()
    |> run()
    |> Map.values()
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> parse()
    |> run2()
    |> Map.values()
    |> Enum.sum()
  end

  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
  end

  def parse_line("mask = " <> mask) do
    zeros = mask |> String.replace(~r{[^0]}, "1") |> String.to_integer(2)
    ones = mask |> String.replace(~r{[^1]}, "0") |> String.to_integer(2)

    crosses =
      mask
      |> String.replace("1", "0")
      |> String.replace("X", "1")
      |> String.to_integer(2)

    {:mask, zeros, ones, crosses}
  end

  def parse_line("mem[" <> line) do
    [address, value] = String.split(line, "] = ")
    {:mem, String.to_integer(address), String.to_integer(value)}
  end

  def run(instructions), do: run(instructions, %{}, {0, 0})

  def run([], mem, _mask), do: mem

  def run([{:mask, zeros, ones, _crosses} | instructions], mem, _mask) do
    run(instructions, mem, {zeros, ones})
  end

  def run([{:mem, address, value} | instructions], mem, mask) do
    mem = set_mem(mem, address, value, mask)
    run(instructions, mem, mask)
  end

  def set_mem(mem, address, value, {zeros, ones}) do
    updated_value = value |> bor(ones) |> band(zeros)
    Map.put(mem, address, updated_value)
  end

  def run2(instructions), do: run2(instructions, %{}, {0, 0})

  def run2([], mem, _mask), do: mem

  def run2([{:mask, _zeros, ones, crosses} | instructions], mem, _mask) do
    run2(instructions, mem, {ones, crosses})
  end

  def run2([{:mem, address, value} | instructions], mem, mask) do
    updated_mem =
      address
      |> addresses(mask)
      |> Enum.reduce(mem, fn addr, acc -> Map.put(acc, addr, value) end)

    run2(instructions, updated_mem, mask)
  end

  def addresses(address, {ones, crossed}) do
    updated_address = bor(address, ones)
    addresses([updated_address], crossed, 1)
  end

  def addresses(addresses, 0, _bit), do: addresses

  def addresses(addresses, crossed, bit) when (crossed &&& bit) == 0 do
    addresses(addresses, crossed, bit <<< 1)
  end

  def addresses(addresses, crossed, bit) do
    addresses1 = Enum.map(addresses, fn addr -> addr ||| bit end)
    addresses2 = Enum.map(addresses, fn addr -> addr &&& bnot(bit) end)
    addresses(addresses1 ++ addresses2, crossed &&& bnot(bit), bit <<< 1)
  end
end
