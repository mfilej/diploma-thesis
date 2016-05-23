defmodule Mix.Tasks.Ngram do
  use Mix.Task

  def run([n]) do
    {n, _} = Integer.parse(n)
    input = IO.read(:stdio, :all)

    Artisan.Ngram.ngram(input, n)
    |> Enum.map(&prep/1)
    |> IO.puts
  end

  defp prep(ngram) do
    ngram = String.replace(to_string(ngram), " ", "_")
    "#{ngram} "
  end
end
