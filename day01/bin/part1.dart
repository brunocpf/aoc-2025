import 'dart:io';
import 'package:args/args.dart';
import 'package:day01/day01.dart' as day01;

void main(List<String> arguments) async {
  const startPosition = 50;
  final parser = ArgParser();
  parser.addOption('input', abbr: 'i', help: 'Path to the input file');

  final argResults = parser.parse(arguments);
  final filePath = argResults['input'];

  if (filePath == null) {
    print('Error: Please provide an input file using --input or -i.');
    print(parser.usage);
    exit(1);
  }

  try {
    final file = File(filePath);
    final contents = await file.readAsString();
    final rotations = contents.split("\n");
    print(
      "Total number of rotations: ${day01.calculateRotationsToZero(startPosition, rotations)}",
    );
  } catch (e) {
    print("Error reading file: $e");
    exit(1);
  }
}
