defmodule AOC.Day21 do
  @moduledoc false

  def part1(input) do
    input
    |> parse()
    |> find_non_allergenic_ingredients()
  end

  def part2(input) do
    input
    |> parse()
    |> find_allergenic_ingredients()
  end

  def find_non_allergenic_ingredients(food) do
    allergens = get_allergens(food)

    food
    |> find_allergenic_ingredients(allergens, %{})
    |> elem(0)
    |> Enum.map(fn {_allergens, ingredients} -> ingredients end)
    |> Enum.reject(fn ingredients -> ingredients == [] end)
    |> List.flatten()
    |> length
  end

  def find_allergenic_ingredients(food) do
    allergens = get_allergens(food)

    food
    |> find_allergenic_ingredients(allergens, %{})
    |> elem(1)
    |> Enum.sort_by(fn {allergen, _ingredient} -> allergen end)
    |> Enum.map(fn {_allergen, ingredient} -> ingredient end)
    |> Enum.join(",")
  end

  def find_allergenic_ingredients(food, [], result) do
    {food, result}
  end

  def find_allergenic_ingredients(food, [allergen | allergens], result) do
    case match_ingredient_and_allergen(food, allergen) do
      [ingredient] ->
        result = Map.put(result, allergen, ingredient)
        food = remove_known_allergen_ingredent(food, allergen, ingredient)
        find_allergenic_ingredients(food, allergens, result)

      _ingredients ->
        find_allergenic_ingredients(food, allergens ++ [allergen], result)
    end
  end

  def match_ingredient_and_allergen(food, allergen) do
    IO.inspect(allergen, label: :allergen)

    food
    |> Enum.filter(fn {allergens, _ingredients} -> allergen in allergens end)
    |> Enum.map(fn {_allergen, ingredients} -> ingredients end)
    |> Enum.reduce(fn ingredients, acc -> intersection(ingredients, acc) end)
    |> IO.inspect(label: :ingredients)
  end

  def remove_known_allergen_ingredent(food, allergen, ingredient) do
    Enum.map(food, fn {allergens, ingredients} ->
      allergens = Enum.reject(allergens, fn a -> a == allergen end)
      ingredients = Enum.reject(ingredients, fn i -> i == ingredient end)
      {allergens, ingredients}
    end)
  end

  def get_allergens(food) do
    food
    |> Enum.reduce([], fn {allergens, _ingredients}, acc -> allergens ++ acc end)
    |> Enum.frequencies()
    |> Enum.sort_by(fn {_allergen, freq} -> freq end, :desc)
    |> Enum.map(fn {allergen, _freq} -> allergen end)

    # |> Map.keys()
  end

  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_food/1)
  end

  def parse_food(line) do
    res = Regex.named_captures(~r/^(?<ingredients>.+) \(contains (?<contains>.+)\)$/, line)
    allegens = res["contains"] |> String.split(", ")
    ingredients = res["ingredients"] |> String.split(" ")
    {allegens, ingredients}
  end

  def intersection(a, b), do: a -- a -- b
end
