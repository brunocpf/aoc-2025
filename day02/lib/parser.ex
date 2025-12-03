defmodule Parser do
  @spec parse_ranges(String.t()) :: list({integer(), integer()})
  def parse_ranges(file_content) do
    Enum.map(
      String.split(file_content, ","),
      fn id_range_str ->
        Enum.map(
          String.split(id_range_str, "-"),
          fn split_range_str -> String.to_integer(split_range_str) end
        )
      end
    )
  end
end
