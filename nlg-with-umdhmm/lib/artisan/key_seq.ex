defmodule Artisan.KeySeq do
  alias Artisan.Alphabet

  def create(input) do
    symbols = Regex.scan(~r/[^[:space:]]+/, input)
    {seq, alphabet} =
      Enum.map_reduce(symbols, Alphabet.new, fn [match], alphabet ->
        alphabet = Alphabet.add(alphabet, match)
        index = Alphabet.index_of(alphabet, match)
        {index + 1, alphabet}
      end)

    {to_pairs(alphabet), length(seq), seq}
  end

  def decode(seq, key_map) do
    Stream.map(seq, fn index -> Map.fetch!(key_map, index) end)
    |> Enum.reduce(fn word, text ->
      case word do
        punct when punct in ~w[. , ? !] -> text <> punct
        word -> text <> " " <> word
      end
    end)
  end

  defp to_pairs(alphabet) do
    Alphabet.to_pairs(alphabet)
    |> Enum.map(fn {symbol, index} -> {index + 1, symbol} end)
  end

  defmodule KeyFile do
    def parse(input) do
      String.splitter(input, "\n", trim: true)
      |> Enum.reduce(Map.new, fn line, map ->
        {key, " \t " <> symbol} = Integer.parse(line)
        Map.put(map, key, symbol)
      end)
    end
  end
end

