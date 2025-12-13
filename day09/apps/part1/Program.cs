using Day09;

var inputPath = ResolveInputPath(args);

if (inputPath == null)
{
    Console.WriteLine("Error: Please provide an input file using --input or -i.");
    return;
}

try
{
    var tiles = RedTiles.Parse(File.ReadLines(inputPath));
    Console.WriteLine($"Result: {RedTiles.LargestArea(tiles)}");
}
catch (Exception e) when (e is IOException or FormatException)
{
    Console.WriteLine($"Error reading file: {e.Message}");
}

static string? ResolveInputPath(string[] args)
{
    var index = Array.IndexOf(args, "--input");

    if (index < 0)
    {
        index = Array.IndexOf(args, "-i");
    }

    if (index >= 0 && index + 1 < args.Length)
    {
        return args[index + 1];
    }

    return args.FirstOrDefault();
}
