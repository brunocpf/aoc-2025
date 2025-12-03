{opts, args, _} = OptionParser.parse(System.argv, switches: [input: :string])

file_path = opts[:input] || List.first(args)

case File.read(file_path) do
  {:ok, content} ->
    ranges = Parser.parse_ranges(content)
    IO.puts("Result: #{Part2.get_result(ranges)}")
  {:error, reason} ->
    IO.puts("Error reading file: #{reason}")
end
