defmodule Mix.Tasks.Artisan.Sim do
  use Mix.Task

  @shortdoc "Simulates Hidden Markov Models"

  @moduledoc """
  #{@shortdoc}.

  Use this task to simulate a given Hidden Markov Model.

  Requires path to .hmm file provided as an argument. Example:

      mix artisan.sim example.hmm
  """

  @len 100

  def run([hmm_file]) do
    :random.seed(:os.timestamp())

    seq = File.read!(hmm_file)
    |> Artisan.HmmFile.parse
    |> Himamo.Sim.simulate(@len)

    IO.puts("T= #{@len}\n" <> Enum.map_join(seq, " ", &(&1 + 1)))
  end
end
