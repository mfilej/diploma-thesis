defmodule Mix.Tasks.Artisan.KeySeq do
  use Mix.Task

  @shortdoc "Turns input text into .key and .seq files"

  @moduledoc """
  #{@shortdoc}.

  Use this task to turn input text into index->word mappings (.key file) and a
  sequence of word indices (.seq file).

  The task requires input text to be provided on stdin.

  The following will produce `example.key` and `example.seq` files:

      cat text.train | mix artisan.key_seq example
  """

  def run([name]) do
    input = IO.read(:stdio, :all)
    {key, len, seq} = Artisan.KeySeq.create(input)

    key_out = Enum.map(key, fn {index, symbol} -> "#{index} \t #{symbol}\n" end)
    len_str = "T= #{len}\n"
    seq_out = Enum.map(seq, &to_string/1) |> Enum.join(" ")

    File.write!("#{name}.key", key_out)
    File.write!("#{name}.seq", [len_str | seq_out])
  end
end
