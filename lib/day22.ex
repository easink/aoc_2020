defmodule AOC.Day22 do
  @moduledoc false

  def part1(input) do
    input
    |> parse()
    |> play_rounds()
    |> count_points()
  end

  def part2(input) do
    input
    |> parse()
    |> play_recursive_combat()
    |> count_points()
  end

  def play_recursive_combat([deck1, deck2]),
    do: play_recursive_combat(deck1, deck2, {[], []})

  def play_recursive_combat(deck1, [], _previous), do: {1, deck1}
  def play_recursive_combat([], deck2, _previous), do: {2, deck2}

  def play_recursive_combat(whole_deck1, whole_deck2, {previous1, previous2}) do
    previous = {[whole_deck1 | previous1], [whole_deck2 | previous2]}
    [card1 | deck1] = whole_deck1
    [card2 | deck2] = whole_deck2

    cond do
      whole_deck1 in previous1 and whole_deck2 in previous2 ->
        {1, whole_deck1}

      card1 <= length(deck1) and card2 <= length(deck2) ->
        new_deck1 = deck1 |> Enum.take(card1)
        new_deck2 = deck2 |> Enum.take(card2)

        case play_recursive_combat(new_deck1, new_deck2, {[], []}) do
          {1, _deck1} -> play_recursive_combat(deck1 ++ [card1, card2], deck2, previous)
          {2, _deck2} -> play_recursive_combat(deck1, deck2 ++ [card2, card1], previous)
        end

      card1 > card2 ->
        play_recursive_combat(deck1 ++ [card1, card2], deck2, previous)

      card2 > card1 ->
        play_recursive_combat(deck1, deck2 ++ [card2, card1], previous)
    end
  end

  def play_rounds([deck1, deck2]), do: play_rounds(deck1, deck2)

  def play_rounds(deck1, []), do: {1, deck1}
  def play_rounds([], deck2), do: {2, deck2}

  def play_rounds([card1 | deck1], [card2 | deck2]) when card1 > card2,
    do: play_rounds(deck1 ++ [card1, card2], deck2)

  def play_rounds([card1 | deck1], [card2 | deck2]),
    do: play_rounds(deck1, deck2 ++ [card2, card1])

  def count_points(deck) do
    deck
    |> elem(1)
    |> Enum.reverse()
    |> Enum.with_index(1)
    |> Enum.reduce(0, fn {point, index}, acc -> acc + point * index end)
  end

  def parse(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(&parse_deck/1)
  end

  def parse_deck(deck) do
    [_player | deck] = deck |> String.split("\n", trim: true)
    Enum.map(deck, &String.to_integer/1)
  end
end
