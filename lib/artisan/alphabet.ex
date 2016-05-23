defmodule Artisan.Alphabet do
  defstruct [size: 0, map: %{}]

  def new, do: %__MODULE__{}
  def add(%__MODULE__{size: size, map: map} = alphabet, symbol) do
    {new_map, new_size} =
      if Map.has_key?(map, symbol) do
        {map, size}
      else
        {Map.put(map, symbol, size), size + 1}
      end

    %{alphabet | size: new_size, map: new_map}
  end

  def index_of(%__MODULE__{map: map}, symbol) do
    Map.fetch!(map, symbol)
  end

  def to_pairs(%__MODULE__{map: map}) do
    map
  end
end
