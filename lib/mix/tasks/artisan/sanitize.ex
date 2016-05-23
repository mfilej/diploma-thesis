defmodule Mix.Tasks.Artisan.Sanitize do
  use Mix.Task

  @shortdoc "Sanitizes input text"

  @moduledoc """
  #{@shortdoc}.

  Receives input text on stdin and sanitizes it by retaining only essential
  punctuacion and normalizing whitespace. The resulting text is output one
  sentence per line.

  Example:

      cat example.txt | mix artisan.sanitize
  """

  def run([]) do
    input = IO.read(:stdio, :all)
    input = Regex.replace ~r/[^\pL',;:.?!\-\s]+/iu, input, ""
    input = Regex.replace ~r/[[:space:]]+/, input, " "
    input = Regex.replace ~r/\.[[:space:]]+/, input, ".\n"

    String.strip(input)
    |> IO.puts
  end

  defmodule Words do
    use Mix.Task

    @shortdoc "Sanitizes input text into a peculiar 'words' format"

    @moduledoc """
    #{@shortdoc}.

    Receives input text on stdin and sanitizes it by normalizing whitespace,
    retaining only essential punctuacion and prepending each punctuation
    character with a space, so they can be treated as separate 'words'. The
    resulting text is output as a single line.

    The output of this task is used to train HMMs.

    Example:

        cat example.txt | mix artisan.sanitize.words
    """

    def run([]) do
      input = IO.read(:stdio, :all)
      input = Regex.replace ~r/[^\pL',;:.?!\-\s]+/iu, input, ""
      input = Regex.replace ~r/[',;:.?!\-\s]+/iu, input, " \\0"
      input = Regex.replace ~r/[[:space:]]+/, input, " "

      input
      |> String.strip
      |> String.downcase
      |> IO.puts
    end
  end
end
