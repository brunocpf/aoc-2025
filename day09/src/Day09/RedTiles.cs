namespace Day09;

public record struct Point(long X, long Y);

public static class RedTiles
{
    public static List<Point> Parse(IEnumerable<string> lines)
    {
        var tiles = new List<Point>();

        foreach (var line in lines)
        {
            if (string.IsNullOrWhiteSpace(line))
            {
                continue;
            }

            var parts = line.Split(',');

            if (parts.Length != 2)
            {
                throw new FormatException($"Invalid tile: {line}");
            }

            tiles.Add(new Point(long.Parse(parts[0]), long.Parse(parts[1])));
        }

        return tiles;
    }

    public static long LargestArea(List<Point> tiles)
    {
        long largest = 0;

        for (var i = 0; i < tiles.Count; i++)
        {
            for (var j = i + 1; j < tiles.Count; j++)
            {
                var width = Math.Abs(tiles[i].X - tiles[j].X) + 1;
                var height = Math.Abs(tiles[i].Y - tiles[j].Y) + 1;
                largest = Math.Max(largest, width * height);
            }
        }

        return largest;
    }

    public static long LargestAreaInsideLoop(List<Point> tiles)
    {
        var segments = BuildSegments(tiles);
        long largest = 0;

        for (var i = 0; i < tiles.Count; i++)
        {
            for (var j = i + 1; j < tiles.Count; j++)
            {
                var minX = Math.Min(tiles[i].X, tiles[j].X);
                var maxX = Math.Max(tiles[i].X, tiles[j].X);
                var minY = Math.Min(tiles[i].Y, tiles[j].Y);
                var maxY = Math.Max(tiles[i].Y, tiles[j].Y);
                var area = (maxX - minX + 1) * (maxY - minY + 1);

                if (area > largest && segments.All(s => s.Y1 >= maxY || s.Y2 <= minY || (minX >= s.X1 && maxX <= s.X2)))
                {
                    largest = area;
                }
            }
        }

        return largest;
    }

    private static List<(long Y1, long Y2, long X1, long X2)> BuildSegments(List<Point> tiles)
    {
        var yValues = tiles.Select(t => t.Y).Distinct().OrderBy(y => y).ToArray();
        var verticalEdges = new List<(long Y1, long Y2, long X)>();
        var segments = new List<(long Y1, long Y2, long X1, long X2)>();

        for (var i = 0; i < tiles.Count; i++)
        {
            var a = tiles[i];
            var b = tiles[(i + 1) % tiles.Count];

            if (a.X == b.X)
            {
                verticalEdges.Add((Math.Min(a.Y, b.Y), Math.Max(a.Y, b.Y), a.X));
            }
        }

        for (var i = 0; i + 1 < yValues.Length; i++)
        {
            var yMid = (yValues[i] + yValues[i + 1]) / 2.0;
            var crossings = verticalEdges
                .Where(e => e.Y1 < yMid && yMid < e.Y2)
                .Select(e => e.X)
                .OrderBy(x => x)
                .ToList();

            for (var k = 0; k + 1 < crossings.Count; k += 2)
            {
                segments.Add((yValues[i], yValues[i + 1], crossings[k], crossings[k + 1]));
            }
        }

        return segments;
    }
}
