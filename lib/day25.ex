defmodule AOC.Day25 do
  @moduledoc false

  @subject_number 7
  @max_number 20_201_227

  def part1({card_pubkey, door_pubkey}) do
    door_loop_size = bruteforce_loop_size(door_pubkey)
    calculate_encryption_key(card_pubkey, door_loop_size)
  end

  def bruteforce_loop_size(pubkey), do: bruteforce_loop_size(1, pubkey, 1)

  def bruteforce_loop_size(value, pubkey, loop_size) do
    subject_number = @subject_number
    value = transform_subject_number(value, subject_number)

    if pubkey == value,
      do: loop_size,
      else: bruteforce_loop_size(value, pubkey, loop_size + 1)
  end

  def calculate_encryption_key(pubkey, loop_size) do
    transform_subject_number(1, pubkey, loop_size)
  end

  def transform_subject_number(value, subject_number) do
    rem(value * subject_number, @max_number)
  end

  def transform_subject_number(value, _subject_number, 0), do: value

  def transform_subject_number(value, subject_number, loop_size) do
    value
    |> transform_subject_number(subject_number)
    |> transform_subject_number(subject_number, loop_size - 1)
  end
end
