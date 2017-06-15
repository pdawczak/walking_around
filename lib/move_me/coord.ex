defmodule MoveMe.Coord do
  @moduledoc """
  Module lets you move around using simple commands.
  """

  defstruct [:x, :y, :dir]

  alias __MODULE__

  @available_dirs ~w( N S E W )a

  def new(x, y, dir) when dir in @available_dirs do
    %Coord{x: x, y: y, dir: dir}
  end

  ###
  # Turning Recht

  def move(%Coord{dir: :N} = coord, :R), do: %{coord | dir: :E}
  def move(%Coord{dir: :E} = coord, :R), do: %{coord | dir: :S}
  def move(%Coord{dir: :S} = coord, :R), do: %{coord | dir: :W}
  def move(%Coord{dir: :W} = coord, :R), do: %{coord | dir: :N}

  ###
  # Turning Links

  def move(%Coord{dir: :N} = coord, :L), do: %{coord | dir: :W}
  def move(%Coord{dir: :E} = coord, :L), do: %{coord | dir: :N}
  def move(%Coord{dir: :S} = coord, :L), do: %{coord | dir: :E}
  def move(%Coord{dir: :W} = coord, :L), do: %{coord | dir: :S}

  ###
  # Going Gehen

  def move(%Coord{y: y, dir: :N} = coord, :G), do: %{coord | y: y + 1}
  def move(%Coord{y: y, dir: :S} = coord, :G), do: %{coord | y: y - 1}
  def move(%Coord{x: x, dir: :E} = coord, :G), do: %{coord | x: x + 1}
  def move(%Coord{x: x, dir: :W} = coord, :G), do: %{coord | x: x - 1}

  ###
  # Multiple steps

  def move(%Coord{} = coord, steps) when is_binary(steps) do
    atom_steps =
      steps
      |> String.codepoints()
      |> Enum.map(&String.to_atom/1)

    move(coord, atom_steps)
  end

  def move(%Coord{} = coord, steps) when is_list(steps) do
    Enum.reduce(steps, coord, fn step, acc_coord -> move(acc_coord, step) end)
  end
end
