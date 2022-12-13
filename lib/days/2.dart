import 'package:advent_of_code_2022/utils/read_input.dart';

void main() {
  final input = readInput(2);
  print(partOne(input));
  print(partTwo(input));
}

int partOne(List<String> input) {
    int rockPoint = 1;
    int paperPoint = 2;
    int scissorPoint = 3;

    bool isRock(String s) => s == 'A' || s == 'X';

    bool isPaper(String s) => s == 'B' || s == 'Y';

    bool isScissor(String s) => s == 'C' || s == 'Z';

    int getPlayPoints(String play) {
      if (isRock(play)) return rockPoint;
      if (isPaper(play)) return paperPoint;
      if (isScissor(play)) return scissorPoint;
      throw UnimplementedError('');
    }

    int matchResults(String player, String opponent) {
  //DRAW
      if (isRock(player) && isRock(opponent) ||
          isPaper(player) && isPaper(opponent) ||
          isScissor(player) && isScissor(opponent)) return 3;
      //WIN
      if (isRock(player) && isScissor(opponent) ||
          isScissor(player) && isPaper(opponent) ||
          isPaper(player) && isRock(opponent)) return 6;
      //LOSE
      return 0;
    }
    int scoreOfPlay(String play) {
      var plays = play.split(' ');
      var opponent = plays.first;
      var player = plays[1];

      var total = 0;

      total += getPlayPoints(player);
      total += matchResults(player, opponent);
      return total;
    }

    return input.map((e) => scoreOfPlay(e)).fold<int>(0, (a, b) => a + b);
  }

int partTwo(List<String> input) {
  int rockPoint = 1;
  int paperPoint = 2;
  int scissorPoint = 3;

  bool isRock(String s) => s == 'A';

  bool isPaper(String s) => s == 'B';

  bool isScissor(String s) => s == 'C';

  int getPlayPoints(String opponent, String result) {
    if (isRock(opponent)) {
      if (result == 'Y') return rockPoint;
      if (result == 'X') return scissorPoint;
      if (result == 'Z') return paperPoint;
    }
    if (isPaper(opponent)) {
      if (result == 'Y') return paperPoint;
      if (result == 'X') return rockPoint;
      if (result == 'Z') return scissorPoint;
    }
    if (isScissor(opponent)) {
      if (result == 'Y') return scissorPoint;
      if (result == 'X') return paperPoint;
      if (result == 'Z') return rockPoint;
    }


    return 0;
  }

  int matchResults(String result) {
//DRAW
    if (result == 'Y') return 3;
    if (result == 'Z') return 6;
    return 0;
  }
  int scoreOfPlay(String play) {
    var plays = play.split(' ');
    var opponent = plays.first;
    var player = plays[1];

    var total = 0;

    total += getPlayPoints(opponent, player);
    total += matchResults(player);
    return total;
  }

  return input.map((e) => scoreOfPlay(e)).fold<int>(0, (a, b) => a + b);
}



