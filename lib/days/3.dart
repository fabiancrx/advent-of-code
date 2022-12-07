import 'package:advent_of_code_2022/utils.dart';

const map = {
  'a': 1,
  'b': 2,
  'c': 3,
  'd': 4,
  'e': 5,
  'f': 6,
  'g': 7,
  'h': 8,
  'i': 9,
  'j': 10,
  'k': 11,
  'l': 12,
  'm': 13,
  'n': 14,
  'o': 15,
  'p': 16,
  'q': 17,
  'r': 18,
  's': 19,
  't': 20,
  'u': 21,
  'v': 22,
  'w': 23,
  'x': 24,
  'y': 25,
  'z': 26,
  'A': 27,
  'B': 28,
  'C': 29,
  'D': 30,
  'E': 31,
  'F': 32,
  'G': 33,
  'H': 34,
  'I': 35,
  'J': 36,
  'K': 37,
  'L': 38,
  'M': 39,
  'N': 40,
  'O': 41,
  'P': 42,
  'Q': 43,
  'R': 44,
  'S': 45,
  'T': 46,
  'U': 47,
  'V': 48,
  'W': 49,
  'X': 50,
  'Y': 51,
  'Z': 52
};

void main() {
  final input = readInput(3);
  print(partOne(input));
  print(partTwo(input));
}

dynamic partOne(List<String> input) {
  int compartment(String a, String b) {
    return a.codeUnits
        .toSet()
        .intersection(b.codeUnits.toSet())
        .first;
  }
  var out = 0;
  for (int i = 0; i < input.length; i ++) {
    final s = input[i];
    var fh = s.substring(0, s.length ~/ 2);
    var sh = s.substring(s.length ~/ 2, s.length);

    var r = compartment(fh, sh);
    out += map[String.fromCharCode(r)]!;
  }
  return out;
}

dynamic partTwo(List<String> input) {
  int compartment(String a, String b, String c) {
    return a.codeUnits
        .toSet()
        .intersection(b.codeUnits.toSet())
        .intersection(c.codeUnits.toSet())
        .first;
  }
  var out = 0;
  for (int i = 3; i <= input.length; i += 3) {
    var r = compartment(input[i - 3], input[i - 1], input[i - 2]);
    out += map[String.fromCharCode(r)]!;
  }
  return out;
}


