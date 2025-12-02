import 'package:day01/day01.dart';
import 'package:test/test.dart';

void main() {
  test('part1', () {
    const startingPosition = 50;
    const input = [
      "L68",
      "L30",
      "R48",
      "L5",
      "R60",
      "L55",
      "L1",
      "L99",
      "R14",
      "L82",
    ];

    expect(calculateRotationsToZero(startingPosition, input), 3);
  });

  test('part2', () {
    const startingPosition = 50;
    const input = [
      "L68",
      "L30",
      "R48",
      "L5",
      "R60",
      "L55",
      "L1",
      "L99",
      "R14",
      "L82",
    ];

    expect(calculateRotationsThroughZero(startingPosition, input), 6);
  });
}
