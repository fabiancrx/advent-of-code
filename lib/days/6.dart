import 'package:advent_of_code_2022/utils.dart';

void main() {
  final input = readInput(6);
  print(partOne(input));
  print(partTwo(input));
}

dynamic partOne(List<String> input) {
  return input.map((e) => process(e, 4)).fold(0, (a, b) => a + b);
}

dynamic partTwo(List<String> input) {
  return input.map((e) => process(e, 14)).fold(0, (a, b) => a + b);
}

int process(String s, int windowSize) {
  for (int i = windowSize; i < s.length; i++) {
    final ss = s.substring(i - windowSize, i).split('');
    if (ss.length == ss.toSet().length) {
      return i;
    }
  }
  throw 'Error processing finding $windowSize distinct chars in $s';
}
