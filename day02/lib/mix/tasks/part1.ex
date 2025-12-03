defmodule Mix.Tasks.Part1 do
  use Mix.Task

  def run(args) do
    {opts, args, _} = OptionParser.parse(args, switches: [input: :string])

    file_path = opts[:input] || List.first(args)

    case File.read(file_path) do
      {:ok, content} ->
        ranges = Day02.Parser.parse_ranges(content)
        IO.puts("Result: #{Day02.Part1.get_result(ranges)}")

      {:error, reason} ->
        IO.puts("Error reading file: #{reason}")
    end
  end
end
