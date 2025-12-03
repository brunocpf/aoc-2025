defmodule Part2 do
  require Integer
  @spec get_result(list({integer(), integer()})) :: integer()
  def get_result(ranges) do
    ranges
    |> Enum.reduce(
      0,
      fn [min, max], result_acc ->
        min..max
        |> Enum.reduce(
          result_acc,
          fn id, acc ->
            id_str = Integer.to_string(id)
            digits = String.length(id_str)

            {res, _} =
              Range.new(1, Integer.floor_div(digits, 2), 1)
              |> Enum.reduce(
                {acc, false},
                fn digit_count, {inner_acc, already_added} ->
                  all_equal =
                    id_str
                    |> String.codepoints()
                    |> Enum.chunk_every(digit_count)
                    |> Enum.map(&Enum.join/1)
                    |> case do
                      [] -> true
                      [head | tail] -> Enum.all?(tail, fn element -> element == head end)
                    end

                  if all_equal && !already_added do
                    {inner_acc + id, true}
                  else
                    {inner_acc, already_added}
                  end
                end
              )

            res
          end
        )
      end
    )
  end
end
