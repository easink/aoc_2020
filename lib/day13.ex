defmodule AOC.Day13 do
  @moduledoc false

  def part1(input) do
    {earliest_depart, buses} = input |> parse()

    buses
    |> find_next_bus(earliest_depart)
    |> wait_time(earliest_depart)
  end

  def part2(input) do
    {_, buses} = input |> parse()

    find_earliest_timestamp(buses)
  end

  def part2_old(input) do
    {_, buses} = input |> parse()

    find_earliest_timestamp_old(buses)
  end

  def part2_stolen(input) do
    {_, buses} = input |> parse()

    next_sequence(buses)
  end

  def parse(input) do
    [earliest_depart, buses] = input |> String.split("\n", trim: true)
    earliest_depart = earliest_depart |> String.to_integer()

    buses =
      buses
      |> String.split(",")
      |> Enum.with_index()
      |> Enum.reject(fn {val, _index} -> val == "x" end)
      |> Enum.map(fn {val, index} -> {String.to_integer(val), index} end)

    # ensure generality (0 <= index <= val)
    # |> Enum.map(fn {val, index} -> {val, rem(index, val)} end)

    {earliest_depart, buses}
  end

  def find_earliest_timestamp_old(buses) do
    {num, rem} = Enum.unzip(buses)
    crt(num, rem)
  end

  def find_earliest_timestamp(buses) do
    buses
    |> buses_to_crt_pairs()
    |> Enum.reduce(&crt_sieve(&1, &2))
    |> elem(0)
  end

  def find_next_bus(buses, earliest_depart),
    do: Enum.min_by(buses, fn {bus_id, _index} -> buss_diff(bus_id, earliest_depart) end)

  def wait_time({bus_id, _index}, earliest_depart),
    do: buss_diff(bus_id, earliest_depart) * bus_id

  def buss_diff(bus_id, earliest_depart),
    do: buss_arrival(bus_id, earliest_depart) - earliest_depart

  def buss_arrival(bus_id, earliest_depart),
    do: bus_id * div(earliest_depart + bus_id - 1, bus_id)

  # def decomposition(n), do: decomposition(n, 2, [])
  # def decomposition(n, k, acc) when n < k * k, do: Enum.reverse(acc, [n])
  # def decomposition(n, k, acc) when rem(n, k) == 0, do: decomposition(div(n, k), k, [k | acc])
  # def decomposition(n, k, acc), do: decomposition(n, k + 1, acc)

  def buses_to_crt_pairs(buses) do
    buses
    |> Enum.map(fn {bus_id, index} -> {rem(bus_id - index, bus_id), bus_id} end)
    |> Enum.sort_by(fn {index, _bus_id} -> index end)
    |> Enum.reverse()
  end

  def crt_sieve({x1, n1}, {a2, n2}) when rem(x1, n2) == a2, do: {x1, n1 * n2}
  def crt_sieve({x1, n1}, pair2), do: crt_sieve({x1 + n1, n1}, pair2)

  def crt(num, rem) do
    prod = Enum.reduce(num, &Kernel.*/2)

    pp = Enum.map(num, fn n -> div(prod, n) end)
    inv = Enum.zip(pp, num) |> Enum.map(fn {p, n} -> modinv(p, n) end)

    [rem, pp, inv]
    |> Enum.zip()
    |> Enum.map(fn {r, m, i} -> r * m * i end)
    |> Enum.sum()
    |> rem(prod)
  end

  def modinv(a, b), do: modinv(a, b, 0, 1, b)

  def modinv(_a, 1, _x0, _x1, _b0), do: 1

  def modinv(a, b, x0, x1, b0) when a > 1 do
    IO.inspect(binding())
    q = div(a, b)
    modinv(b, rem(a, b), x1 - q * x0, x0, b0)
  end

  def modinv(_a, _b, _x0, x1, b0) when x1 < 0, do: x1 + b0
  def modinv(_a, _b, _x0, x1, _b0), do: x1
  # def egcd(x, 0), do: {x, 1, 0}

  # def egcd(x, y) do
  #   {gcd, a, b} = egcd(y, rem(x, y))
  #   {gcd, b, a - div(x, y) * b}
  # end

  # def modinv(x, m) do
  #   {_gcd, res, _y} = egcd(x, m)
  #   if res < 0, do: res + m, else: res
  #   # {_gcd, x, _y} = egcd(a, m)
  #   # rem(rem(x, m) + m, m)
  # end

  # def lcm(a, b), do: div(a * b, Integer.gcd(a, b))

  # stolen by Voltone
  def next_sequence(busses) do
    busses
    # |> Enum.with_index()
    |> Enum.reduce({0, 1}, &add_to_sequence/2)
    |> elem(0)
  end

  # defp add_to_sequence({"x", _index}, state), do: state
  defp add_to_sequence({bus, index}, {t, step}) do
    if Integer.mod(t + index, bus) == 0 do
      {t, lcm(step, bus)}
    else
      add_to_sequence({bus, index}, {t + step, step})
    end
  end

  defp lcm(a, b) do
    div(a * b, Integer.gcd(a, b))
  end
end
