import 'package:advent_of_code_2022/utils.dart';

const visible = 1;
const notVisible = 0;

void main() {
  final input = readInput(8);
  final List<List<int>> grid = input.map((e) => e.split('').map((a) => int.parse(a)).toList()).toList();
  print(partOne(grid));
  print(partTwo(grid));
}

dynamic partOne(List<List<int>> grid) {
  List<List<int>> output = [
    for (var sublist in grid) [...sublist]
  ];
  var visibleCount = 0;
  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[i].length; j++) {
      if (i == 0 || i == grid.length - 1 || j == 0 || j == grid[i].length - 1) {
        visibleCount++;
        output[i][j] = visible;
        continue;
      } else {
        final isTreeVisible = isVisible(grid, i, j);

        if (isTreeVisible) {
          visibleCount++;
        }
        output[i][j] = isVisible(grid, i, j) ? visible : notVisible;
      }
    }
  }
  return visibleCount;
}

dynamic partTwo(List<List<int>> grid) {
  int maxScenicScore = 0;
  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[i].length; j++) {
      int score = scenicScore(grid, j, i);
      if (score > maxScenicScore) {
        maxScenicScore = score;
      }
    }
  }
  return maxScenicScore;
}

bool isVisible(List<List<int>> grid, int x, int y) {
  final value = grid[x][y];

  bool isVisibleUp = true, isVisibleDown = true, isVisibleLeft = true, isVisibleRight = true;

  for (int i = x - 1; i >= 0; i--) {
    if (grid[i][y] >= value) {
      isVisibleLeft = false;
      break;
    }
  }

  for (int i = x + 1; i < grid[x].length; i++) {
    if (grid[i][y] >= value) {
      isVisibleRight = false;
      break;
    }
  }
  for (int i = y - 1; i >= 0; i--) {
    if (grid[x][i] >= value) {
      isVisibleUp = false;
      break;
    }
  }

  for (int i = y + 1; i < grid.length; i++) {
    if (grid[x][i] >= value) {
      isVisibleDown = false;
      break;
    }
  }

  return isVisibleLeft || isVisibleRight || isVisibleUp || isVisibleDown;
}

int scenicScore(List<List<int>> grid, int x, int y) {
  final value = grid[x][y];

  int leftScore = 0;
  for (int i = x - 1; i >= 0; i -= 1) {
    leftScore += 1;
    final height = grid[i][y];
    if (height >= value) {
      break;
    }
  }
  int rightScore = 0;
  for (int i = x + 1; i < grid[x].length; i += 1) {
    rightScore += 1;
    final height = grid[i][y];
    if (height >= value) {
      break;
    }
  }
  int upScore = 0;
  for (int j = y - 1; j >= 0; j -= 1) {
    upScore += 1;
    final height = grid[x][j];
    if (height >= value) {
      break;
    }
  }
  int downScore = 0;
  for (int j = y + 1; j < grid.length; j += 1) {
    downScore += 1;
    final height = grid[x][j];
    if (height >= value) {
      break;
    }
  }
  return leftScore * rightScore * upScore * downScore;
}
