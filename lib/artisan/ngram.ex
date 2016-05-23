defmodule Artisan.Ngram do
  def ngram(input, n) when is_binary(input) do
    ngram(String.to_char_list(input), n)
  end

  def ngram(input, n) when is_list(input) do
    Enum.chunk(input, n, 1)
  end
end
