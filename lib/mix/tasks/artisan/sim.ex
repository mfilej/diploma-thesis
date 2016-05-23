defmodule Mix.Tasks.Artisan.Sim do
  use Mix.Task

  @shortdoc "Simulates Hidden Markov Models"

  @moduledoc """
  #{@shortdoc}.

  Use this task to simulate a given Hidden Markov Model.

  Requires path to .hmm file provided as an argument.

      mix artisan.sim example.hmm 100

  The above example will generate a sample text with 100 words (including
  punctuation).
  """

  def run([hmm_file, len]) do
    :random.seed(:os.timestamp())
    {len, _} = Integer.parse(len)

    seq = File.read!(hmm_file)
    |> Artisan.HmmFile.parse
    |> Himamo.Sim.simulate(len)

    IO.puts("T= #{len}\n" <> Enum.map_join(seq, " ", &(&1 + 1)))
  end
end
