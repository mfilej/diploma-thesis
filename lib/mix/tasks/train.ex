defmodule Mix.Tasks.Train do
  use Mix.Task
  def run(_) do
    IO.read(:stdio, :all)
    |> String.splitter("\n")
    |> Prepare.prepare_observations
    |> Model.build
    |> IO.inspect
  end
end

defmodule Prepare do
  def prepare_observations(sentences) do
    Enum.reduce(sentences, {Artisan.Alphabet.new, []}, fn line, {alphabet, obs_list} ->
      ngrams = Artisan.Ngram.ngram(line, 8)

      alphabet = append_alphabet_symbols(alphabet, ngrams)
      ngram_indices = map_ngrams_to_alphabet_indices(alphabet, ngrams)
      obs_list = append_observation(ngram_indices, obs_list)

      {alphabet, obs_list}
    end)
  end

  defp append_alphabet_symbols(alphabet, ngrams) do
    Enum.reduce(ngrams, alphabet, fn ngram, alphabet ->
      Artisan.Alphabet.add(alphabet, ngram)
    end)
  end

  defp map_ngrams_to_alphabet_indices(alphabet, ngrams) do
    Enum.map(ngrams, fn(symbol) ->
      Artisan.Alphabet.index_of(alphabet, symbol)
    end)
  end

  defp append_observation([], observations) do
    observations
  end
  defp append_observation(observation, observations) when is_list(observation) do
    [observation | observations]
  end
end

defmodule Model do
  def a(n) do
    import Himamo.Model.A, only: [new: 1, put: 3]

    for i <- 0..n-1, j <- 0..n-1 do
      {{i, j}, 1/n}
      end |> Enum.reduce(new(n), fn({key, p}, a) ->
        put(a, key, p)
      end)
  end

  def b(n, m) do
    import Himamo.Model.B, only: [new: 1, put: 3]

    for v <- 0..m-1, j <- 0..n-1 do
      {{j, v}, 1/n}
      end |> Enum.reduce(new(n: n, m: m), fn({key, p}, b) ->
        put(b, key, p)
      end)
  end

  defp build_model(n, m) do
    %Himamo.Model{
      a: a(n),
      b: b(n, m),
      pi: Himamo.Model.Pi.new(List.duplicate(1/n, n)),
      n: n,
      m: m,
    }
  end

  def build({alphabet, obs_list}) do
    model = build_model(5, alphabet.size)
    Himamo.Training.train(model, obs_list, 1.0e-60)
  end
end
