import 'package:advent_of_code_2022/utils/read_input.dart';

void main() {
  final input = readInput(9);

  print(partOne(input));
  print(partTwo(input));
}

dynamic partOne(List<String> input) {
  return pepe(input, 2);
}

dynamic partTwo(List<String> input) {
  return pepe(input, 10);
}

dynamic pepe(List<String> input, int ropeLength) {
  List<Point> knots = List.generate(ropeLength, (_) => Point());

  Set<Point> visitedPositions = {};

  final head = knots.first;
  final tail = knots.last;

  for (final line in input) {
    final times = int.parse(line.split(' ')[1]);

    for (int i = 0; i < times; i++) {
      if (line.startsWith('L')) head.x -= 1;
      if (line.startsWith('R')) head.x += 1;
      if (line.startsWith('U')) head.y -= 1;
      if (line.startsWith('D')) head.y += 1;
      moveTail(knots);

      visitedPositions.add(tail.clone());
    }
  }

  return visitedPositions.length;
}

void moveTail(List<Point> knots) {
// Move knots when the tail is long
  for (int i = 1; i < knots.length; i++) {
    final head = knots[i];
    final tail = knots[i - 1];

    int deltaX = tail.x - head.x;
    int deltaY = tail.y - head.y;

    if (deltaX.abs() > 1 || deltaY.abs() > 1) {
      if (deltaX.abs() >= 1) {
        if (deltaX > 0)
          head.x += 1;
        else
          head.x -= 1;
      }
      if (deltaY.abs() >= 1) {
        if (deltaY > 0)
          head.y += 1;
        else
          head.y -= 1;
      }
    }
  }
}

class Point {
  int x;
  int y;

  Point({
    this.x = 0,
    this.y = 0,
  });

  Point clone() => Point(x: x, y: y);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Point && runtimeType == other.runtimeType && x == other.x && y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}
