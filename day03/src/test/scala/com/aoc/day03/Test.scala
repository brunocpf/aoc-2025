import com.aoc.day03.Challenge

class ChallengeTest extends org.scalatest.funsuite.AnyFunSuite {
  test("Challenge.part1") {
    val banks = List(
      List(9, 8, 7, 6, 5, 4, 3, 2, 1, 1, 1, 1, 1, 1, 1),
      List(8, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9),
      List(2, 3, 4, 2, 3, 4, 2, 3, 4, 2, 3, 4, 2, 7, 8),
      List(8, 1, 8, 1, 8, 1, 9, 1, 1, 1, 1, 2, 1, 1, 1)
    )

    assert(Challenge.part1(banks) === 357)
  }

  test("Challenge.part2") {
    val banks = List(
      List(9, 8, 7, 6, 5, 4, 3, 2, 1, 1, 1, 1, 1, 1, 1),
      List(8, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9),
      List(2, 3, 4, 2, 3, 4, 2, 3, 4, 2, 3, 4, 2, 7, 8),
      List(8, 1, 8, 1, 8, 1, 9, 1, 1, 1, 1, 2, 1, 1, 1)
    )

    assert(Challenge.part2(banks) === 3121910778619L)
  }
}
