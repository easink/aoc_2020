defmodule AOC.Day24 do
  @moduledoc false

  @reference_tile {0, 0, 0}

  def part1(input) do
    input
    |> parse()
    |> gen_tiles()
    |> add_tiles_colour()
    |> black_tiles()
    |> length
  end

  def part2(input, days) do
    input
    |> parse()
    |> gen_tiles()
    |> add_tiles_colour()
    |> black_tiles()
    |> art_exhibits(days)
    |> length
  end

  def art_exhibits(tiles, 0), do: tiles

  def art_exhibits(tiles, days) do
    tiles
    |> art_exhibit()
    |> black_tiles()
    |> art_exhibits(days - 1)
  end

  def art_exhibit(black_tiles) do
    black_tiles
    |> add_white_neighbours()
    |> art_exhibit(black_tiles, [])
  end

  def art_exhibit([], _black_tiles, result), do: result

  # white
  def art_exhibit([{cube, 0} | tiles], black_tiles, result) do
    if black_neighbours(black_tiles, cube) == 2,
      do: art_exhibit(tiles, black_tiles, [{cube, 1} | result]),
      else: art_exhibit(tiles, black_tiles, [{cube, 0} | result])
  end

  # black
  def art_exhibit([{cube, 1} | tiles], black_tiles, result) do
    case black_neighbours(black_tiles, cube) do
      1 -> art_exhibit(tiles, black_tiles, [{cube, 1} | result])
      2 -> art_exhibit(tiles, black_tiles, [{cube, 1} | result])
      _ -> art_exhibit(tiles, black_tiles, [{cube, 0} | result])
    end
  end

  def add_white_neighbours(black_tiles), do: add_white_neighbours(black_tiles, black_tiles)
  def add_white_neighbours([], tiles), do: tiles

  def add_white_neighbours([{cube, 1} | black_tiles], tiles) do
    updated_tiles =
      cube
      |> neighbours()
      |> Enum.reduce(tiles, fn cube, acc ->
        if cube_member?(acc, cube), do: acc, else: [{cube, 0} | acc]
      end)

    add_white_neighbours(black_tiles, updated_tiles)
  end

  def black_neighbours(tiles, cube) do
    neighbours = neighbours(cube)

    Enum.filter(tiles, fn
      {_cube, 0} -> false
      {cube, 1} -> cube in neighbours
    end)
    |> length
  end

  def cube_member?(tiles, cube),
    do: Enum.find(tiles, fn {tile_cube, _color} -> tile_cube == cube end)

  def gen_tiles(tiles), do: Enum.map(tiles, &tile/1)

  def add_tiles_colour(tiles) do
    tiles
    |> Enum.frequencies()
    |> Enum.map(fn {cube, freq} -> {cube, to_colour(freq)} end)
  end

  def black_tiles(tile_freqs) do
    Enum.filter(tile_freqs, fn {_cube, freq} -> to_colour(freq) == 1 end)
  end

  def to_colour(freq), do: rem(freq, 2)

  def tile(tile), do: tile(@reference_tile, tile)

  def tile(cube, []), do: cube

  def tile(cube, [direction | tile]) do
    cube
    |> neighbour(direction)
    |> tile(tile)
  end

  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_tile/1)
  end

  def neighbour({x, y, z} = _cube, :west), do: {x - 1, y + 1, z}
  def neighbour({x, y, z} = _cube, :east), do: {x + 1, y - 1, z}
  def neighbour({x, y, z} = _cube, :south_west), do: {x - 1, y + 0, z + 1}
  def neighbour({x, y, z} = _cube, :south_east), do: {x + 0, y - 1, z + 1}
  def neighbour({x, y, z} = _cube, :north_west), do: {x + 0, y + 1, z - 1}
  def neighbour({x, y, z} = _cube, :north_east), do: {x + 1, y + 0, z - 1}

  def neighbours(cube) do
    [
      neighbour(cube, :west),
      neighbour(cube, :east),
      neighbour(cube, :south_west),
      neighbour(cube, :south_east),
      neighbour(cube, :north_west),
      neighbour(cube, :north_east)
    ]
  end

  def parse_tile(line), do: parse_tile(line, [])

  def parse_tile("", tile), do: Enum.reverse(tile)
  def parse_tile("e" <> line, tile), do: parse_tile(line, [:east | tile])
  def parse_tile("w" <> line, tile), do: parse_tile(line, [:west | tile])
  def parse_tile("se" <> line, tile), do: parse_tile(line, [:south_east | tile])
  def parse_tile("sw" <> line, tile), do: parse_tile(line, [:south_west | tile])
  def parse_tile("ne" <> line, tile), do: parse_tile(line, [:north_east | tile])
  def parse_tile("nw" <> line, tile), do: parse_tile(line, [:north_west | tile])
end
