module Tests

open Xunit

[<Fact>]
let ``Part1 Test`` () =
    let ranges = [ 3L, 5L; 10L, 14L; 16L, 20L; 12L, 18L ]
    let ingredients = [ 1L; 5L; 8L; 11L; 17L; 32L ]

    let result = Part1.getResult ranges ingredients

    Assert.Equal(3L, result)


[<Fact>]
let ``Part2 Test`` () =
    let ranges = [ 3L, 5L; 10L, 14L; 16L, 20L; 12L, 18L ]

    let result = Part2.getResult ranges

    Assert.Equal(14L, result)
