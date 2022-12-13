import 'package:collection/collection.dart';
import 'package:fpdart/fpdart.dart';

class Dijkstra {
  Dijkstra(this.graph);

  final List<List<int>> graph;

  List<Tuple2<int, int>> neighbours(Tuple2<int, int> source) {
    final x = source.first;
    final y = source.second;

    final possibleNeighbours = [
      if (y + 1 < graph[x].length) Tuple2(x, y + 1),
      if (y - 1 >= 0) Tuple2(x, y - 1),
      if (x - 1 >= 0) Tuple2(x - 1, y),
      if (x + 1 < graph.length) Tuple2(x + 1, y),
    ];
    final filtered =
        possibleNeighbours.where((t) => graph[t.first][t.second] - graph[source.first][source.second] <= 1).toList();

    return filtered;
  }

  Iterable<Tuple2<int, int>>? shortestPath(Tuple2<int, int> start, Tuple2<int, int> goal) {

    final paths = <Tuple2<int, int>, double>{start: 0};
    final prev = <Tuple2<int, int>, Tuple2<int, int>>{};

    final queue =
        PriorityQueue<Tuple2<int, int>>((a, b) => (paths[a] ?? double.infinity).compareTo(paths[b] ?? double.infinity))
          ..add(start);

    while (queue.isNotEmpty) {
      var current = queue.removeFirst();

      if (current == goal) {
        final path = [current];
        while (prev.keys.contains(current)) {
          current = prev[current]!;
          path.prepend(current);
        }
        return path;
      }

      for (final neighbor in neighbours(current)) {
        final alt = paths[current]! + 1;
        if (alt < (paths[neighbor] ?? double.infinity)) {
          paths[neighbor] = alt;
          prev[neighbor] = current;
          queue.add(neighbor);
        }
      }
    }
  }
}
