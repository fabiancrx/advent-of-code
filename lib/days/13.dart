import 'dart:convert';

import 'package:advent_of_code_2022/utils/read_input.dart';
import 'package:fpdart/fpdart.dart';

void main() {
  final input = readInput(13);
  print(partOne(input));
  print(partTwo(input));
}

List<Tuple2> parseInput(List<String> input) {
  dynamic fromStr(String line) {
    return jsonDecode(line);
  }

  var grandLines = <Tuple2>[];
  for (int i = 0; i < input.length; i += 3) {
    var l = fromStr(input[i]);
    var r = fromStr(input[i + 1]);
    grandLines.add(Tuple2(l, r));
  }

  return grandLines;
}


bool? areEqual(Tuple2 pair) {
  final left = pair.first;
  final right = pair.second;
  // print('Compare $left vs $right');

  if (left is int) {
    if (right is int) {
      if (left < right) return true;
      if (left > right) return false;
      return null;
    } else {
      return areEqual(Tuple2([left], right));
    }
  } else {
    if (right is int) {
      return areEqual(Tuple2(left, [right]));
    }
  }
  if (left is Iterable && right is Iterable) {
    for (int i = 0; i < left.length; i++) {
      if (i >= right.length) return false;
      final result = areEqual(Tuple2(left.elementAt(i), right.elementAt(i)));
      if (result != null) return result;
    }
    if (left.length < right.length) return true;
  }
}

int compFn(dynamic a, dynamic b) {
  final res = areEqual(Tuple2(a, b));
  if (res == null) return 0;
  return res ? -1 : 1;
}

dynamic partOne(List<String> input) {
  var pairs = parseInput(input);
  var sum = <int>[];
  for (int i = 0; i < pairs.length; i++) {
    if (areEqual(pairs[i]) ?? false) {
      sum.add(i + 1);
    }
  }
  return sum.fold(0, (a, b) => a + b);
}

dynamic partTwo(List<String> input) {
  var pairs = parseInput(input);

  var entries = [
    for (final p in pairs) ...[p.first, p.second]
  ];

  final dividerPacket2=  [[2]];
  final dividerPacket6=  [[6]];

  entries..add(dividerPacket2)..add(dividerPacket6);

  entries.sort(compFn);


  var dividerPacketIndices = <int>[
  entries.indexOf(dividerPacket2)+1,
  entries.indexOf(dividerPacket6)+1,
  ];

  return dividerPacketIndices.fold(1, (a, b) => a * b);
}
