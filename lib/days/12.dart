import 'package:advent_of_code_2022/utils/djikstra.dart';
import 'package:advent_of_code_2022/utils/read_input.dart';
import 'package:fpdart/fpdart.dart';

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

  'E': 99,
  'S': 0,
};

void main() {
  final input = readInput(12).map((e) => e.split('').map((e) => map[e]!).toList()).toList();
  final input2 = readInput(12).map((e) => e.split('').map((e) => map[e]!).toList()).toList();

  print(partOne(input));
  print(partTwo(input2));
}

dynamic partOne(List<List<int>> input) {
  final start = firstPosition(input, 0, 1)!;
  final goal = firstPosition(input, 99, 26)!;

  final dijkstra = Dijkstra(input);
  final path = dijkstra.shortestPath(start, goal);
  return (path?.length ?? 0) - 1;
}

dynamic partTwo(List<List<int>> input) {
  final startPoints = <Tuple2<int, int>>[];
  for (int i = 0; i < input.length; i++) {
    for (int j = 0; j < input[i].length; j++) {
      if (input[i][j] <= 1) {
        if (input[i][j] == 0) {
          input[i][j] = 1;
        }
        startPoints.add(Tuple2(i, j));
      }
    }
  }
  final goal = firstPosition(input, 99, 26)!;

  final trackDistances = [];

  final dijkstra = Dijkstra(input);
  for (final pos in startPoints) {
    final pathDistance = dijkstra.shortestPath(pos, goal);
    if (pathDistance != null) {
      trackDistances.add((pathDistance.length - 1));
    }
  }

  return trackDistances.first;

}





Tuple2<int, int>? firstPosition(List<List<int>> input, int value, [int? replace]) {
  for (int i = 0; i < input.length; i++) {
    for (int j = 0; j < input[i].length; j++) {
      if (input[i][j] == value) {
        if (replace != null) {
          input[i][j] = replace;
        }
        return Tuple2(i, j);
      }
    }
  }
}
