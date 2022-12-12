
import 'package:collection/collection.dart';

void main() {
  final input = _input;
  // print(partOne(input));
  print(partTwo(input));
}

final List<Monkey> testInput = [
  Monkey(id: 0, items: [79, 98], operation: (o) => o * 19, modulo: 23, trueMonkeyId: 2, falseMonkeyId: 3),
  Monkey(id: 1, items: [54, 65, 75, 74], operation: (o) => o + 6, modulo: 19, trueMonkeyId: 2, falseMonkeyId: 0),
  Monkey(id: 2, items: [79, 60, 97], operation: (o) => o * o, modulo: 13, trueMonkeyId: 1, falseMonkeyId: 3),
  Monkey(id: 3, items: [74], operation: (o) => o + 3, modulo: 17, trueMonkeyId: 0, falseMonkeyId: 1)
];
final List<Monkey> _input = [
  Monkey(id: 0, items: [84, 72, 58, 51], operation: (o) => o * 3, modulo: 13, trueMonkeyId: 1, falseMonkeyId: 7),
  Monkey(id: 1, items: [88, 58, 58], operation: (o) => o + 8, modulo: 2, trueMonkeyId: 7, falseMonkeyId: 5),
  Monkey(
      id: 2,
      items: [93, 82, 71, 77, 83, 53, 71, 89],
      operation: (o) => o * o,
      modulo: 7,
      trueMonkeyId: 3,
      falseMonkeyId: 4),
  Monkey(
      id: 3,
      items: [81, 68, 65, 81, 73, 77, 96],
      operation: (o) => o + 2,
      modulo: 17,
      trueMonkeyId: 4,
      falseMonkeyId: 6),
  Monkey(id: 4, items: [75, 80, 50, 73, 88], operation: (o) => o + 3, modulo: 5, trueMonkeyId: 6, falseMonkeyId: 0),
  Monkey(
      id: 5, items: [59, 72, 99, 87, 91, 81], operation: (o) => o * 17, modulo: 11, trueMonkeyId: 2, falseMonkeyId: 3),
  Monkey(id: 6, items: [86, 69], operation: (o) => o + 6, modulo: 3, trueMonkeyId: 1, falseMonkeyId: 0),
  Monkey(id: 7, items: [91], operation: (o) => o + 1, modulo: 19, trueMonkeyId: 2, falseMonkeyId: 5),
];

dynamic partOne(List<Monkey> input) {
  for (int i = 0; i < 20; i++) {
    for (var monkey in input) {
      monkey.playRound1(input);
    }
  }
  return monkeyBusiness(input);
}

int monkeyBusiness(List<Monkey> monkeys) {
  final m = monkeys.sorted((a, b) => b.inspectedCount.compareTo(a.inspectedCount));
  final ic = m.sublist(0, 2).map((e) => e.inspectedCount);
  print(ic);
  return ic.fold(1, (a, b) => a * b);
}

dynamic partTwo(List<Monkey> input) {
  // 1.Calculating just with Dart `int` will easily overflow the 64 bits.
  // 2.Trying to use `BigInt` solves the overflow issue, but in practice is too slow for the large numbers this problem.
  // 3. A third method is, as we only care about the modulo of the operation, not the # itself, we can just % the number.
  // The issue with using the `modulo` of each monkey independently is that items are passed from monkey to monkey.
  // Eg: if we have an item with the # 27 with a monkey with modulo 5, 27 %5  is 2.
  // But if we pass that item to a monkey with modulo 3, 2%3  is 2. But the value should be 0, because if we passed the original 27 %3 is 0.
  // So we can't modulo each monkey independently, we calculate the LCM (Lowest common multiple)(Actually just a common multiple, might not be the lowest), and we % by that #, which is guaranteed to
  // give us the remainder we need no matter which #/monkey.
  final lcm = input.map((e) => e.modulo).fold(1, (a, b) => (a * b)~/a.gcd(b));
  print('lcm $lcm');
  for (int i = 0; i < 10000; i++) {
    for (var monkey in input) {
      monkey.playRound2(input, lcm);
    }
  }
  return monkeyBusiness(input);
}

class Monkey {
  int id;
  List<int> items;
  int Function(int old) operation;
  int modulo;
  int trueMonkeyId;
  int falseMonkeyId;
  int inspectedCount = 0;

  Monkey({
    required this.id,
    required this.items,
    required this.operation,
    required this.modulo,
    required this.trueMonkeyId,
    required this.falseMonkeyId,
  });

  void playRound1(List<Monkey> monkeys) {
    for (var element in items) {
      var nwl = operation(element) ~/ 3;
      int monkeyId = nwl % modulo == 0 ? trueMonkeyId : falseMonkeyId;
      monkeys.firstWhere((element) => element.id == monkeyId).items.add(nwl);

      //   print('''
      //     Monkey inspects an item with a worry level of $element.
      // Worry level increases by  ${operation(element)}.
      // Monkey gets bored with item. Worry level is divided by 3 to $nwl.
      // Current worry level is ${test(nwl)}.
      // Item with worry level $nwl is thrown to monkey $monkeyId.
      //   ''');

      inspectedCount++;
    }

    items.clear();
  }

  void playRound2(List<Monkey> monkeys, int mod) {
    for (var element in items) {
      var nwl = operation(element) % mod;
      int monkeyId = (nwl % modulo == 0) ? trueMonkeyId : falseMonkeyId;
      monkeys.firstWhere((element) => element.id == monkeyId).items.add(nwl);
      inspectedCount++;
    }

    items.clear();
  }

  @override
  String toString() {
    return 'Monkey{inspectedCount: $inspectedCount}';
  }


// factory Monkey.fromString(List<String> s){
//   int id;
//   List<int> items;
//   for (var line in s) {
//     if (line.startsWith('Monkey')) {
//       id = int.parse(
//           line.substring(0, s.length - 1).split(' ')[1]);
//     }
//     else if (line.startsWith('Starting items:')) {
//       items = line.split(':')[1].split(',').map((e) => int.parse(e)).toList();
//     }else if(line.startsWith('Operation:')){
//
//     }
//   }
//
//   final monkey = Monkey(id: id,
//       items: items,
//       operation: operation,
//       test: test,
//       trueMonkeyId: trueMonkeyId,
//       falseMonkeyId: falseMonkeyId)
// }

}
