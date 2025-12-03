int calculateRotationsToZero(int startPosition, List<String> rotations) {
  var currentPosition = startPosition;
  var rotationsToZero = 0;

  for (final rotation in rotations) {
    currentPosition = ((currentPosition + parseRotation(rotation)) % 100).abs();

    if (currentPosition == 0) {
      rotationsToZero++;
    }
  }

  return rotationsToZero;
}

int calculateRotationsThroughZero(int startPosition, List<String> rotations) {
  var currentPosition = startPosition;
  var rotationsThroughZero = 0;

  for (final rotation in rotations) {
    final rotationValue = parseRotation(rotation);
    final dest = currentPosition + rotationValue;
    rotationsThroughZero += (dest.abs() / 100).floor();

    if (dest <= 0 && currentPosition != 0) {
      rotationsThroughZero += 1;
    }

    currentPosition = (dest % 100).abs();
  }

  return rotationsThroughZero;
}

int parseRotation(String rotation) {
  if (rotation.isEmpty) {
    return 0;
  }

  final direction = rotation[0];

  try {
    final rotationAmount = int.parse(rotation.substring(1));

    switch (direction) {
      case "R":
        return rotationAmount;
      case "L":
        return -rotationAmount;
      default:
        {
          throw FormatException("Invalid direction");
        }
    }
  } catch (e) {
    return 0;
  }
}
