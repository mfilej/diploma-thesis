defmodule Artisan.HmmFileTest do
  use ExUnit.Case
  alias Artisan.HmmFile

  def example do
    Path.join(__DIR__, "../fixtures/example.hmm")
    |> File.read!
  end

  def expected_a do
    import Himamo.Model.A, only: [new: 1, put: 3]
    new(3)
    |> put({0, 0}, 0.001000) |> put({0, 1}, 0.002000) |> put({0, 2}, 0.997000)
    |> put({1, 0}, 0.003000) |> put({1, 1}, 0.004000) |> put({1, 2}, 0.993000)
    |> put({2, 0}, 0.000002) |> put({2, 1}, 0.999997) |> put({2, 2}, 0.000001)
  end

  def expected_b do
    import Himamo.Model.B, only: [new: 1, put: 3]
    new(n: 3, m: 5)
    |> put({0, 0}, 0.003000) |> put({0, 1}, 0.007990) |> put({0, 2}, 0.500500) |> put({0, 3}, 0.011111) |> put({0, 4}, 0.477399)
    |> put({1, 0}, 0.001000) |> put({1, 1}, 0.001001) |> put({1, 2}, 0.496500) |> put({1, 3}, 0.001000) |> put({1, 4}, 0.500499)
    |> put({2, 0}, 0.001000) |> put({2, 1}, 0.496696) |> put({2, 2}, 0.001000) |> put({2, 3}, 0.500302) |> put({2, 4}, 0.001002)
  end

  def expected_pi do
    Himamo.Model.Pi.new([0.997999, 0.001001, 0.001000])
  end

  test "instantiates Himamo.Model from HMM file" do
    assert HmmFile.parse(example) == %Himamo.Model{
      a: expected_a,
      b: expected_b,
      pi: expected_pi,
      n: 3,
      m: 5,
    }
  end
end
