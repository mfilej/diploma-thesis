defmodule Mix.Tasks.KeySeq do
  use Mix.Task

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
