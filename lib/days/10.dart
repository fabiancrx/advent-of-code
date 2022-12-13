import 'package:advent_of_code_2022/utils/read_input.dart';

void main() {
  final input = readInput(10);
  print(partOne(input));
  print(partTwo(input));
}

dynamic partOne(List<String> input) {
  var tick = 0;
  var x = 1;
  var output = 0;
  void checkTick() {
    if (tick == 20 || (tick - 20) % 40 == 0) {
      // print('tick $tick O->${output}  X $x * T $tick ${x * tick}');
      output += x * tick;
    }
  }

  for (var cycle in input) {
    if (cycle.startsWith('noop')) {
      tick++;
      checkTick();
    } else if (cycle.startsWith('addx')) {
      final times = int.parse(cycle.split(' ')[1]);

      tick++;
      checkTick();
      tick++;
      // if (tick > 180 && tick <= 220)
      //   print('T $times x $x [$tick]');
      checkTick();

      x += times;
      // if (tick > 180 && tick <= 220)
      // print('X $x [$tick]');
    }
  }
  return output;
}

dynamic partTwo(List<String> input) {
  final crt = List.filled(240, ".");
  var tick = 0;
  var x = 1;

  void paintCRT() {
    final _tick = (tick - 1) % 40;
    if (_tick == x - 1 || _tick == x || _tick == x + 1) {
      crt[tick - 1] = "#";
    }
  }

  for (var cycle in input) {
    if (cycle.startsWith('noop')) {
      tick++;
      paintCRT();
    } else if (cycle.startsWith('addx')) {
      final times = int.parse(cycle.split(' ')[1]);

      tick++;
      paintCRT();
      tick++;
      paintCRT();

      x += times;
    }
  }
  String crtAsGrid() {
    final buffer = StringBuffer();
    for (int i = 0; i < 6; i++) {
      buffer.writeln(crt.sublist(40 * i, 40 * (i + 1)).join(''));
    }
    return buffer.toString();
  }

  return crtAsGrid();
}
