import 'dart:io';

List<String> readInput(int day) {
  final path = 'lib/input/$day.txt';
  final file = File(path);

  final input = file.readAsLinesSync();

  return input;
}
