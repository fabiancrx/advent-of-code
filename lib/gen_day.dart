import 'dart:developer';
import 'dart:io';

void main(List<String> args) {
  try {
    var currentDay = 0;
    if (args.isNotEmpty) {
      currentDay = int.parse(args[0]);
    }
    if (args.isEmpty) {
      final daysDir = Directory('lib/days');
      if (!daysDir.existsSync()) {
        throw Exception('Days directory not found at ${daysDir.path}');
      }
      final lastDay = daysDir
          .listSync()
          .where((e) => e.path.endsWith('.dart'))
          .map((e) => e.uri.pathSegments.last.split('.dart'))
          .last[0];
      currentDay = int.parse(lastDay) + 1;
    }
    // Generate file
    File('lib/input/$currentDay.txt').writeAsString('');
    File('lib/days/$currentDay.dart').writeAsString(
      '''
import 'package:advent_of_code_2022/read_input.dart';

void main() {
  final input = readInput($currentDay);
  print(partOne(input));
  // print(partTwo(input));
}

dynamic partOne(List<String> input) {
  return -1;
}

dynamic partTwo(List<String> input) {
  return -1;
}
    ''',
    );
  } catch (e, st) {
    log('Error generating day with args $args', error: e, stackTrace: st);
  }
}
