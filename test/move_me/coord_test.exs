defmodule MoveMe.CoordTest do
  use ExUnit.Case

  alias MoveMe.Coord

  test "builds new instance of Coord" do
    coord = Coord.new(1, 3, :N)

    assert coord.x == 1
    assert coord.y == 3
    assert coord.dir == :N
  end

  test "moving to North" do
    coord = Coord.new(1, 3, :N)

    new_coord = Coord.move(coord, :G)

    assert new_coord.x == 1
    assert new_coord.y == 4
    assert new_coord.dir == :N
  end

  test "moving to South" do
    coord = Coord.new(1, 3, :S)

    new_coord = Coord.move(coord, :G)

    assert new_coord.x == 1
    assert new_coord.y == 2
    assert new_coord.dir == :S
  end

  test "moving to East" do
    coord = Coord.new(1, 3, :E)

    new_coord = Coord.move(coord, :G)

    assert new_coord.x == 2
    assert new_coord.y == 3
    assert new_coord.dir == :E
  end

  test "moving to West" do
    coord = Coord.new(1, 3, :W)

    new_coord = Coord.move(coord, :G)

    assert new_coord.x == 0
    assert new_coord.y == 3
    assert new_coord.dir == :W
  end

  test "turning to Recht" do
    coord = Coord.new(1, 3, :N)

    coord = Coord.move(coord, :R)
    assert coord.dir == :E

    coord = Coord.move(coord, :R)
    assert coord.dir == :S

    coord = Coord.move(coord, :R)
    assert coord.dir == :W

    coord = Coord.move(coord, :R)
    assert coord.dir == :N
  end

  test "turning to Links" do
    coord = Coord.new(1, 3, :N)

    coord = Coord.move(coord, :L)
    assert coord.dir == :W

    coord = Coord.move(coord, :L)
    assert coord.dir == :S

    coord = Coord.move(coord, :L)
    assert coord.dir == :E

    coord = Coord.move(coord, :L)
    assert coord.dir == :N
  end

  test "walking around" do
    coord = Coord.new(1, 2, :N)

    new_coord = Coord.move(coord, [:G, :R, :G, :L, :G])

    assert new_coord.x == 2
    assert new_coord.y == 4
    assert new_coord.dir == :N
  end

  test "walking around lead by binaries" do
    coord = Coord.new(1, 2, :N)

    new_coord = Coord.move(coord, "GRGLG")

    assert new_coord.x == 2
    assert new_coord.y == 4
    assert new_coord.dir == :N
  end
end
