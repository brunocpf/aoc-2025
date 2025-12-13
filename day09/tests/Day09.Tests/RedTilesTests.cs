using Day09;

namespace Day09.Tests;

public class RedTilesTests
{
    private static readonly List<Point> Example = RedTiles.Parse(
        ["7,1", "11,1", "11,7", "9,7", "9,5", "2,5", "2,3", "7,3"]);

    [Fact]
    public void LargestArea()
    {
        Assert.Equal(50L, RedTiles.LargestArea(Example));
    }

    [Fact]
    public void LargestAreaInsideLoop()
    {
        Assert.Equal(24L, RedTiles.LargestAreaInsideLoop(Example));
    }
}
