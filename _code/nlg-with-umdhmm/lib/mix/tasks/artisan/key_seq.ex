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

    key_file = "#{name}.key"
    seq_file = "#{name}.seq"

    File.write!(key_file, key_out)
    IO.puts :stderr, "Key file written to #{key_file}"
    File.write!(seq_file, [len_str | seq_out])
    IO.puts :stderr, "Sequence file written to #{seq_file}"
    IO.puts :stderr, "Number of symbols in alphabet: #{length(key)}"
    IO.puts "#{length(key)}"
  end
end
