defmodule Mix.Tasks.Artisan.Decode do
  use Mix.Task

  @shortdoc "Decodes sequence of symbol indexes into words"

  @moduledoc """
  #{@shortdoc}.

  Use this task to decode a .seq file containing word indices into readable
  text. Requires path to .key file as argument, .seq file is given on stdin.

      cat example.seq | mix artisan.decode example.key
  """

  def run(args) do
    key_file = hd(args)
    offset = Enum.at(args, 1, :no_offset)

    "T= " <> rest = IO.read(:stdio, :all)
    {_len, "\n" <> rest} = Integer.parse(rest)

    key_map =
      File.read!(key_file)
      |> Artisan.KeySeq.KeyFile.parse
      |> apply_key_file_offset(offset)

    String.splitter(rest, "\n",  trim: true)
    |> Enum.map(fn line ->
      line_to_list_of_keys(line)
      |> Artisan.KeySeq.decode(key_map)
      |> IO.puts
    end)
  end

  defp apply_key_file_offset(key_file, :no_offset), do: key_file
  defp apply_key_file_offset(key_file, "-1") do
    Enum.reduce(key_file, Map.new, fn ({index, word}, offset_map) ->
      Map.put(offset_map, index - 1, word)
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
