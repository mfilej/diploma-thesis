defmodule Artisan.AlphabetTest do
  use ExUnit.Case
  alias Artisan.Alphabet

  test "adding symbols to an empty alphabet" do
    alphabet = Alphabet.new |> Alphabet.add("foo")

    assert alphabet.size == 1
    assert Alphabet.index_of(alphabet, "foo") == 0
  end

  test "only new symbols increase alphabet size" do
    alphabet =
      Alphabet.new
      |> Alphabet.add("foo")
      |> Alphabet.add("foo")
      |> Alphabet.add("bar")

    assert alphabet.size == 2
    assert Alphabet.index_of(alphabet, "bar") == 1
  end

  test "returns all index-symbol pairs" do
    alphabet =
      Alphabet.new
      |> Alphabet.add("hi")
      |> Alphabet.add("there")
      |> Alphabet.add("who")
      |> Alphabet.add("there")

    assert Alphabet.to_pairs(alphabet) == %{
      "hi" => 0,
      "there" => 1,
      "who" => 2,
    }
  end
end
