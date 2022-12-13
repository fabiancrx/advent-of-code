import 'dart:math';

import 'package:advent_of_code_2022/utils/read_input.dart';

void main() {
  final input = readInput(1);
  print(partOne(input));
  print(partTwo(input));
}

int partOne(List<String> input) {
  var maxValue = -1;

  var accumulated = 0;

  for (var line in input) {
    if (line.isEmpty) {
      maxValue = max(accumulated, maxValue);
      accumulated = 0;
    } else {
      accumulated += int.parse(line);
    }
  }
  return maxValue;
}

int partTwo(List<String> input) {
  var accumulated = 0;
  var elvesCalories = <int>[];
  for (var line in input) {
    if (line.isEmpty) {
      elvesCalories.add(accumulated);
      accumulated = 0;
    } else {
      accumulated += int.parse(line);
    }
  }
  elvesCalories.sort();
  return elvesCalories.reversed.take(3).fold<int>(0, (a, b) => a + b);
}
