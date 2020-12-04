defmodule AOC.Day04 do
  @moduledoc false

  defmodule Passport do
    defstruct [:ecl, :pid, :eyr, :hcl, :byr, :iyr, :cid, :hgt]
  end

  def part1(input) do
    count_valid(input, &simple_validate_passport/1)
  end

  def part2(input) do
    count_valid(input, &validate_passport/1)
  end

  def keys(), do: %Passport{} |> Map.from_struct() |> Map.keys()

  def count_valid(input, valid_fun) do
    input
    |> String.split("\n\n")
    |> Enum.map(&String.split/1)
    |> Enum.map(&create_passport(&1, %Passport{}))
    |> Enum.map(&valid_fun.(&1))
    |> Enum.count(&(&1 == true))
  end

  def create_passport([], passport), do: passport

  def create_passport([entry | entries], passport) do
    [key, value] = String.split(entry, ":")
    mapkey = Enum.find(keys(), fn k -> Atom.to_string(k) == key end)
    create_passport(entries, %{passport | mapkey => value})
  end

  def simple_validate_passport(passport) do
    %Passport{passport | cid: "ignore"}
    |> Map.from_struct()
    |> Map.values()
    |> Enum.count(fn x -> x == nil end)
    |> Kernel.==(0)
  end

  def validate_passport(passport) do
    true
    |> validate_byr(passport.byr)
    |> validate_iyr(passport.iyr)
    |> validate_eyr(passport.eyr)
    |> validate_hgt(passport.hgt)
    |> validate_hcl(passport.hcl)
    |> validate_ecl(passport.ecl)
    |> validate_pid(passport.pid)
  end

  def validate_byr(_valid, nil), do: false

  def validate_byr(valid, value) do
    byr = String.to_integer(value)
    valid and 1920 <= byr and byr <= 2002
  end

  def validate_iyr(_valid, nil), do: false

  def validate_iyr(valid, value) do
    iyr = String.to_integer(value)
    valid and 2010 <= iyr and iyr <= 2020
  end

  def validate_eyr(_valid, nil), do: false

  def validate_eyr(valid, value) do
    eyr = String.to_integer(value)
    valid and 2020 <= eyr and eyr <= 2030
  end

  def validate_hgt(_valid, nil), do: false

  def validate_hgt(valid, value) do
    case Integer.parse(value) do
      {inch, "in"} -> valid and 59 <= inch and inch <= 76
      {cm, "cm"} -> valid and 150 <= cm and cm <= 193
      _ -> false
    end
  end

  def validate_hcl(_valid, nil), do: false

  def validate_hcl(valid, "#" <> value) do
    case Integer.parse(value, 16) do
      {_, ""} -> valid
      _ -> false
    end
  end

  def validate_hcl(_valid, _value), do: false

  def validate_ecl(_valid, nil), do: false

  def validate_ecl(valid, value) do
    valid and value in ~w(amb blu brn gry grn hzl oth)
  end

  def validate_pid(_valid, nil), do: false

  def validate_pid(valid, value) do
    valid and String.length(value) == 9 and
      value |> String.to_charlist() |> Enum.all?(&(&1 in ?0..?9))
  end
end
