defmodule Artisan.KeySeqTest do
  use ExUnit.Case
  alias Artisan.KeySeq

  @input """
  i just sort of always feel sick without you baby .
  i ain 't got anything to lick without you baby .
  nothing really sticks without you baby .
  ain 't i fallen in love ?
  """

  test "maps words form input text to index-word pairs" do
    {key, _len ,_seq} = KeySeq.create(@input)

    expected = [
      {18, "nothing"},
      {21, "fallen"},
      {22, "in"},
      {23, "love"},
      {10, "baby"},
      {12, "ain"},
      { 8, "without"},
      { 3, "sort"},
      { 2, "just"},
      { 5, "always"},
      {24, "?"},
      {17, "lick"},
      {19, "really"},
      {11, "."},
      { 4, "of"},
      {13, "'t"},
      {14, "got"},
      {20, "sticks"},
      { 9, "you"},
      { 7, "sick"},
      {15, "anything"},
      {16, "to"},
      { 6, "feel"},
      { 1, "i"},
    ]

    assert sort(key) == sort(expected)
  end

  test "maps text to sequence of indices" do
    {_key, len, seq} = KeySeq.create(@input)

    assert len == 36
    assert seq == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 1, 12, 13, 14, 15, 16,
      17, 8, 9, 10, 11, 18, 19, 20, 8, 9, 10, 11, 12, 13, 1, 21, 22, 23, 24]
  end

  @key_map %{
    1 => "foo",
    2 => "bar",
    3 => "baz",
    4 => ".",
    5 => ",",
  }

  test "maps sequence of indices to text" do
    result = Artisan.KeySeq.decode([1, 2, 1, 3, 2, 1], @key_map)
    assert result == "foo bar foo baz bar foo"
  end

  test "joins punctuation without inserting a space" do
    result = Artisan.KeySeq.decode([1, 2, 5, 3, 2, 1, 4], @key_map)
    assert result == "foo bar, baz bar foo."
  end

  defp sort(list_of_pairs) do
    Enum.sort_by(list_of_pairs, fn({k, _v}) -> k end)
  end
end

defmodule Artisan.KeySeq.KeyFileTest do
  use ExUnit.Case

  def key_file do
    Path.join(__DIR__, "../fixtures/example_2.key")
    |> File.read!
  end

  test "reads contents of .key file into a map" do
    expected = %{
       9 => "you",
      11 => ".",
      23 => "?",
      10 => "baby",
       4 => "of",
      15 => "to",
      22 => "love",
       7 => "sick",
       6 => "feel",
      12 => "aint",
      20 => "fallen",
       5 => "always",
       3 => "sort",
      18 => "really",
       1 => "i",
      13 => "got",
      19 => "sticks",
       8 => "without",
      17 => "nothing",
      21 => "in",
      16 => "lick",
      14 => "anything",
       2 => "just",
    }

    assert Artisan.KeySeq.KeyFile.parse(key_file) == expected
  end
end
