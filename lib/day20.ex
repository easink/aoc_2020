defmodule AOC.Day20 do
  @moduledoc false

  def part1(input) do
    input
    |> parse()
    |> generate_photo()
    |> photo_corners()
    |> multiply_corners()
  end

  def part2(input) do
    input
    |> parse()
    |> generate_photo()
    |> generate_actual_photo()
    |> monochrome_alternatives()
    |> Enum.find_value(&find_sea_monsters/1)
    |> rough_waters()
  end

  def generate_actual_photo(photo) do
    photo
    |> Enum.map(fn {coord, tile} -> {coord, remove_border_from_tile(tile)} end)
    |> Enum.into(%{})
    |> merge_tiles()
  end

  def merge_tiles(photo) do
    n = tiles_in_map(photo)

    for y <- 0..(n - 1) do
      for(x <- 0..(n - 1), do: Map.get(photo, {y, x}))
      |> Enum.zip()
      |> Enum.map(&Tuple.to_list/1)
      |> Enum.map(&List.flatten/1)
    end
    |> Enum.reduce([], fn block, acc -> acc ++ block end)
  end

  def monochrome_alternatives(huge_tile) do
    r0 = huge_tile
    f0 = huge_tile |> flip_tile()
    r1 = r0 |> rotate_tile()
    f1 = f0 |> rotate_tile()
    r2 = r1 |> rotate_tile()
    f2 = f1 |> rotate_tile()
    r3 = r2 |> rotate_tile()
    f3 = f2 |> rotate_tile()
    [r0, f0, r1, f1, r2, f2, r3, f3]
  end

  def convert_huge_tile_to_coords(huge_tile) do
    n = length(huge_tile)

    for(y <- 0..(n - 1), x <- 0..(n - 1), do: {y, x})
    |> Enum.zip(List.flatten(huge_tile))
    |> Enum.filter(fn {_coord, x} -> x == ?# end)
    |> Enum.map(fn {coord, _x} -> coord end)
  end

  def rough_waters({monsters, huge_tile_coords}) do
    length(huge_tile_coords) - monsters * sea_monster_size()
  end

  def find_sea_monsters(huge_tile) do
    huge_tile_coords = huge_tile |> convert_huge_tile_to_coords()
    size = length(huge_tile)

    all_positions = for(y <- 0..(size - 1), x <- 0..(size - 1), do: {y, x})

    monsters =
      Enum.filter(all_positions, fn pos ->
        Enum.all?(sea_monster(pos), &Enum.member?(huge_tile_coords, &1))
      end)
      |> length()

    if monsters > 0, do: {monsters, huge_tile_coords}, else: false
  end

  def sea_monster_size(), do: sea_monster({0, 0}) |> length()

  def sea_monster({y_pos, x_pos}) do
    #                   #
    # #    ##    ##    ###
    #  #  #  #  #  #  #
    sea_monster = [
      {0, 18},
      {1, 0},
      {1, 5},
      {1, 6},
      {1, 11},
      {1, 12},
      {1, 17},
      {1, 18},
      {1, 19},
      {2, 1},
      {2, 4},
      {2, 7},
      {2, 10},
      {2, 13},
      {2, 16}
    ]

    Enum.map(sea_monster, fn {y, x} -> {y + y_pos, x + x_pos} end)
  end

  def remove_border_from_tile({_tilenum, {tile, _left, _up, _right, _down}}) do
    n = length(tile)

    tile
    |> List.delete_at(n - 1)
    |> tl()
    |> Enum.map(fn row -> row |> List.delete_at(n - 1) |> tl() end)
  end

  def generate_photo(tiles) do
    coords = coords(tiles)
    generate_photo(tiles, %{}, coords)
  end

  def generate_photo(_tiles, photo, []), do: photo

  def generate_photo(tiles, photo, [coord | coords]) do
    match_left = get_left_side(photo, coord)
    match_up = get_up_side(photo, coord)

    Enum.find_value(tiles, fn {tile, alternatives} ->
      updated_tiles = Map.delete(tiles, tile)

      alternatives
      |> filter_matching_sides(match_left, match_up)
      |> Enum.find_value(fn side ->
        updated_photo = Map.put(photo, coord, {tile, side})
        generate_photo(updated_tiles, updated_photo, coords)
      end)
    end)
  end

  def photo_corners(photo) do
    n = tiles_in_map(photo) - 1
    c0 = Map.get(photo, {0, 0}) |> elem(0)
    c1 = Map.get(photo, {0, n}) |> elem(0)
    c2 = Map.get(photo, {n, 0}) |> elem(0)
    c3 = Map.get(photo, {n, n}) |> elem(0)
    [c0, c1, c2, c3]
  end

  def multiply_corners(corners),
    do: Enum.reduce(corners, &(&1 * &2))

  def filter_matching_sides(sides, match_left, match_up) do
    Enum.filter(sides, fn {_tile, left, up, _right, _down} ->
      (match_left == nil and match_up == nil) or
        (match_left == nil and match_up == up) or
        (match_left == left and match_up == nil) or
        (match_left == left and match_up == up)
    end)
  end

  def get_left_side(_photo, {_y, 0}), do: nil

  def get_left_side(photo, {y, x}) do
    {_tilenum, {_tile, _left, _up, right, _down}} = Map.get(photo, {y, x - 1})
    right
  end

  def get_up_side(_photo, {0, _x}), do: nil

  def get_up_side(photo, {y, x}) do
    {_tilenum, {_tile, _left, _up, _right, down}} = Map.get(photo, {y - 1, x})
    down
  end

  def parse(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(&parse_tile/1)
    |> Enum.into(%{})
  end

  def parse_tile(tile) do
    [title | tile] = tile |> String.split("\n", trim: true)
    title = Regex.named_captures(~r/^Tile (?<tile_num>[0-9]+):$/, title)
    tile_num = Map.get(title, "tile_num") |> String.to_integer()
    {tile_num, tile_sides(tile)}
  end

  def tile_sides(tile) do
    tile = Enum.map(tile, &String.to_charlist/1)

    tile
    |> tile_num_sides()
    |> tile_alternatives()
  end

  def coords(tiles) do
    n = tiles_in_map(tiles)

    for(y <- 0..(n - 1), x <- 0..(n - 1), do: {y, x})
    |> Enum.sort_by(fn {y, x} -> y + x end)
  end

  def tiles_in_map(tiles), do: tiles |> map_size() |> :math.sqrt() |> trunc()

  def tile_num_side(side), do: tile_num_side(side, 0)
  def tile_num_side([], num), do: num

  def tile_num_side([?# | side], num), do: tile_num_side(side, num * 2 + 1)
  def tile_num_side([?. | side], num), do: tile_num_side(side, num * 2 + 0)

  def num_reverse(num) do
    <<a::1, b::1, c::1, d::1, e::1, f::1, g::1, h::1, i::1, j::1>> = <<num::10>>
    <<updated_num::10>> = <<j::1, i::1, h::1, g::1, f::1, e::1, d::1, c::1, b::1, a::1>>
    updated_num
  end

  def tile_num_sides(tile) do
    up_side = List.first(tile) |> tile_num_side()
    down_side = List.last(tile) |> tile_num_side()
    left_side = Enum.map(tile, fn line -> List.first(line) end) |> tile_num_side()
    right_side = Enum.map(tile, fn line -> List.last(line) end) |> tile_num_side()
    {tile, left_side, up_side, right_side, down_side}
  end

  def tile_alternatives(sides) do
    front_sides = sides |> tile_rotation_alternatives()
    back_sides = sides |> flip() |> tile_rotation_alternatives()
    front_sides ++ back_sides
  end

  def tile_rotation_alternatives(sides) do
    r0 = sides
    r1 = rotate(r0)
    r2 = rotate(r1)
    r3 = rotate(r2)
    [r0, r1, r2, r3]
  end

  def rotate({tile, left, up, right, down}),
    do: {rotate_tile(tile), down, num_reverse(left), up, num_reverse(right)}

  def rotate_tile(tile) do
    Enum.reduce(tile, fn row, acc ->
      row
      |> Enum.zip(acc)
      |> Enum.map(&Tuple.to_list/1)
      |> Enum.map(&List.flatten/1)
    end)
  end

  def flip({tile, left, up, right, down}),
    do: {flip_tile(tile), num_reverse(left), down, num_reverse(right), up}

  def flip_tile(tile), do: Enum.reverse(tile)
end
