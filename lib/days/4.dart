import 'package:advent_of_code_2022/utils.dart';

void main() {
  final input = readInput(4);
  print(partOne(input));
  print(partTwo(input));
}

dynamic partOne(List<String> input) {
  var output = 0;
  for (var line in input) {
    final first = buildRange(line.split(',').first).toSet();
    final second = buildRange(line.split(',').last).toSet();

    final isContained = first.difference(second).isEmpty || second.difference(first).isEmpty;
    if (isContained) {
      output++;
    }
  }

  return output;
}

dynamic partTwo(List<String> input) {
  var output = 0;
  for (var line in input) {
    final first = buildRange(line.split(',').first).toSet();
    final second = buildRange(line.split(',').last).toSet();

    final isIntersection = first.intersection(second).isNotEmpty;
    if (isIntersection) {
      output++;
    }
  }

  return output;
}

List<int> buildRange(String r) {
  final first = int.parse(r.split('-').first);
  final second = int.parse(r.split('-').last);

  if (first == second) return [first];

  return List.generate(second - first + 1, (i) => first + i);
}
