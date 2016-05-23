defmodule Mix.Tasks.Sim do
  use Mix.Task

  @len 100

  def run([hmm_file]) do
    :random.seed(:os.timestamp())

    seq = File.read!(hmm_file)
    |> Artisan.HmmFile.parse
    |> Himamo.Sim.simulate(@len)

    IO.puts("T= #{@len}\n" <> Enum.map_join(seq, " ", &(&1 + 1)))
  end
end
