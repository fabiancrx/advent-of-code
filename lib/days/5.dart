import 'dart:collection';

import 'package:advent_of_code_2022/utils.dart';

// [N]     [C]                 [Q]
// [W]     [J] [L]             [J] [V]
// [F]     [N] [D]     [L]     [S] [W]
// [R] [S] [F] [G]     [R]     [V] [Z]
// [Z] [G] [Q] [C]     [W] [C] [F] [G]
// [S] [Q] [V] [P] [S] [F] [D] [R] [S]
// [M] [P] [R] [Z] [P] [D] [N] [N] [M]
// [D] [W] [W] [F] [T] [H] [Z] [W] [R]
//  1   2   3   4   5   6   7   8   9

List<Queue<String>> crates() =>
    [
      Queue.from(['D', 'M', 'S', 'Z', 'R', 'F', 'W', 'N']),
      Queue.from(['W', 'P', 'Q', 'G', 'S']),
      Queue.from(['W', 'R', 'V', 'Q', 'F', 'N', 'J', 'C']),
      Queue.from(['F', 'Z', 'P', 'C', 'G', 'D', 'L']),
      Queue.from(['T', 'P', 'S']),
      Queue.from(['H', 'D', 'F', 'W', 'R', 'L']),
      Queue.from(['Z', 'N', 'D', 'C']),
      Queue.from(['W', 'N', 'R', 'F', 'V', 'S', 'J', 'Q']),
      Queue.from(['R', 'M', 'S', 'G', 'Z', 'W', 'V']),
    ];

// final List<Queue<String>> samplePepe =[
// Queue.from(['Z','N']),
// Queue.from(['M','C','D']),
// Queue.from(['P']),
// ];

void main() {
  final input = readInput(5);
  print(partOne(input));
  print(partTwo(input));
}

dynamic partOne(List<String> input) {
  final pepe = crates();
  for (var line in input) {
    final moveInstruction = line.split(' ');
    final amount = int.parse(moveInstruction[1]);
    final from = int.parse(moveInstruction[3]) - 1;
    final to = int.parse(moveInstruction[5]) - 1;

    final c = pepe[from];
    var holder = <String>[];
    for (int i = 0; i < amount; i++) {
      holder.add(c.removeLast());
    }
    pepe[to].addAll(holder);
  }

  return pepe.map((e) => e.last).join('');
}

dynamic partTwo(List<String> input) {
  final pepe = crates();

  for (var line in input) {
    final moveInstruction = line.split(' ');
    final amount = int.parse(moveInstruction[1]);
    final from = int.parse(moveInstruction[3]) - 1;
    final to = int.parse(moveInstruction[5]) - 1;

    final c = pepe[from];
    var holder = <String>[];
    for (int i = 0; i < amount; i++) {
      holder.add(c.removeLast());
    }
    pepe[to].addAll(holder.reversed);
  }

  return pepe.map((e) => e.last).join('');
}

