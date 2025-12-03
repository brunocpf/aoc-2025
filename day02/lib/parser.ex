defmodule Day02.Parser do
  @spec parse_ranges(String.t()) :: list({integer(), integer()})
  def parse_ranges(file_content) do
    Enum.map(
      String.split(file_content, ",", trim: true),
      fn id_range_str ->
        Enum.map(
          String.split(id_range_str, "-", trim: true),
          fn split_range_str -> String.to_integer(split_range_str) end
        )
        |> List.to_tuple()
      end
    )
  end
end
