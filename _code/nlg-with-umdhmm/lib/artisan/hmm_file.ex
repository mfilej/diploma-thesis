defmodule Artisan.HmmFile do
  def parse(lines) do
    String.split(lines, "\n")
    |> parse_lines(%Himamo.Model{})
  end

  defp parse_lines(["M= " <> m | rem_lines],  model) do
    {m, ""} = Integer.parse(m)
    parse_lines(rem_lines, %{model | m: m})
  end
  defp parse_lines(["N= " <> n | rem_lines],  model) do
    {n, ""} = Integer.parse(n)
    parse_lines(rem_lines, %{model | n: n})
  end
  defp parse_lines(["A:" <> _ | rem_lines], model) do
    matrix = Himamo.Model.A.new(model.n)
    {rem_lines, matrix} = parse_matrix(rem_lines, model, matrix)

    parse_lines(rem_lines, %{model | a: matrix})
  end
  defp parse_lines(["B:" <> _ | rem_lines], model) do
    matrix = Himamo.Model.B.new(n: model.n, m: model.m)
    {rem_lines, matrix} = parse_matrix(rem_lines, model, matrix)

    parse_lines(rem_lines, %{model | b: matrix})
  end
  defp parse_lines(["pi:" <> _ | [pi_line | rem_lines]], model) do
    pi =
      split_line(pi_line)
      |> Enum.map(fn prob -> {prob, ""} = Float.parse(prob); prob end)
      |> Himamo.Model.Pi.new

    parse_lines(rem_lines, %{model | pi: pi})
  end
  defp parse_lines(["" | lines], model) do
    parse_lines(lines, model)
  end
  defp parse_lines([], model), do: model

  defp parse_matrix(rem_lines, model, matrix) do
    {matrix_lines, rem_lines} =
      Enum.map_reduce(1..model.n, rem_lines, fn _i, [line | lines] ->
        {line, lines}
      end)

    matrix = parse_matrix_lines(Enum.with_index(matrix_lines), matrix)

    {rem_lines, matrix}
  end

  defp parse_matrix_lines([{line, j} | rem_lines], matrix) do
    matrix =
      split_line(line)
      |> Enum.with_index
      |> Enum.reduce(matrix, fn {trans_prob, i}, curr_matrix ->
        {trans_prob, ""} = Float.parse(trans_prob)
        Himamo.Matrix.put(curr_matrix, {i, j}, trans_prob)
      end)

    parse_matrix_lines(rem_lines, matrix)
  end
  defp parse_matrix_lines([], a), do: a

  defp split_line(line) do
    String.splitter(line, " ", trim: true)
  end
end
