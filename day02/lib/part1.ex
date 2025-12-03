defmodule Part1 do
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

            if Integer.is_even(digits) do
              {first_half, second_half} = String.split_at(id_str, digits |> div(2))

              if first_half == second_half do
                acc + id
              else
                acc
              end
            else
              acc
            end
          end
        )
      end
    )
  end
end
