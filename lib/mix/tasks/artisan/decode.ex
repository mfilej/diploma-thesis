defmodule Mix.Tasks.Artisan.Decode do
  use Mix.Task

  @shortdoc "Decodes sequence of symbol indexes into words"

  @moduledoc """
  #{@shortdoc}.

  Use this task to decode a .seq file containing word indices into readable
  text. Requires path to .key file as argument, .seq file is given on stdin.

      cat example.seq | mix artisan.decode example.key
  """

  def run([key_file]) do
    "T= " <> rest = IO.read(:stdio, :all)
    {_len, "\n" <> rest} = Integer.parse(rest)

    key_map = File.read!(key_file) |> Artisan.KeySeq.KeyFile.parse

    String.splitter(rest, "\n",  trim: true)
    |> Enum.map(fn line ->
      line_to_list_of_keys(line)
      |> Artisan.KeySeq.decode(key_map)
      |> IO.puts
    end)
  end

  defp line_to_list_of_keys(line) do
    line
    |> String.rstrip
    |> String.splitter(" ", trim: true)
    |> Stream.map(fn key ->
      case Integer.parse(key) do
        {key, ""} ->  key
        :error -> raise("can't parse stdin at #{inspect(key)}")
      end
    end)
  end
end
