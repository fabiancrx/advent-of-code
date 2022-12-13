import 'package:advent_of_code_2022/utils/read_input.dart';
import 'package:collection/collection.dart';

void main() {
  final input = readInput(7);
  print(partOne(input));
  print(partTwo(input));
}

dynamic partOne(List<String> input) {
  var output = 0;

  final root = TreeNode('/');
  buildTree(root, input);

  final resp = <TreeNode>[];

  smallerThan([root], 100000, resp);

  for (final e in resp) {
    output += e.size();
  }

  return output;
}

dynamic partTwo(List<String> input) {
  final root = TreeNode('/');
  buildTree(root, input);

  final resp = <TreeNode>[];

  smallerThan([root], 70000000, resp);

  final rootSize = root.size();
  final unusedSpace = 70000000 - rootSize;
  final requiredMinimumSpace = 30000000 - unusedSpace;

  final i = idealNodeToRemove(unusedSpace, requiredMinimumSpace, resp);

  return i.size();
}

TreeNode buildTree(TreeNode root, List<String> input) {
  var current = root;
  for (var line in input) {
    current = walk(line, current);
  }
  return root;
}

TreeNode walk(String s, TreeNode t) {
  if (s.startsWith('\$ cd ')) {
    var parts = s.split(' ');
    return processCD(parts[2], t);
  } else {
    if (s.startsWith('\$ ls')) {
      return t;
    }
    processLS(s, t);
    return t;
  }
}

TreeNode processCD(String s, TreeNode t) {
  if (s.endsWith('..')) {
    return t.parent ?? t;
  } else if (s.endsWith('/')) {
    var tempNode = t;
    while (tempNode.parent != null) {
      tempNode = tempNode.parent!;
    }
    return tempNode;
  } else {
    final name = s;
    if (t.hasChild(name)) {
      final child = t.children.firstWhere((element) => element.name == name);
      return child;
    } else {
      final newNode = TreeNode(name, parent: t);
      t.addChild(newNode);
      return newNode;
    }
  }
}

void processLS(String line, TreeNode t) {
  if (line.startsWith('dir')) {
    final newNode = TreeNode(line.split(' ')[1], parent: t);
    t.addChild(newNode);
  } else {
    final newNode = TreeNode(line.split(' ')[1], value: int.parse(line.split(' ')[0]), parent: t);
    t.addChild(newNode);
  }
}

// Returns all nodes smaller than [amount]
List<TreeNode> smallerThan(List<TreeNode> nodes, int amount, List<TreeNode> resp) {
  for (final c in nodes) {
    if (c.isDir) {
      var size = c.size();
      if (size <= amount) {
        resp.add(c);
      }
      smallerThan(c.children.where((element) => element.isDir).toList(), amount, resp);
    }
  }
  return resp;
}

TreeNode idealNodeToRemove(int unusedSpace, int targetSpace, List<TreeNode> resp) {
  final nums = resp.sorted((a, b) => a.size().compareTo(b.size()));

  final item = nums.firstWhere((e) => e.size() > targetSpace);

  return item;
}

void _display(List<TreeNode> nodes, [int deep = 0]) {
  for (final c in nodes) {
    print('${' ' * deep}${c.toString()}');
    _display(c.children, deep + 1);
  }
}

// N-ary tree
class TreeNode {
  TreeNode? parent;
  final int value;
  final String name;
  List<TreeNode> children = [];

  TreeNode(this.name, {this.value = 0, this.parent});

  void addChild(TreeNode t) {
    if (hasChild(t.name)) {
      return;
    } else {
      children.add(t);
      t.parent = this;
    }
  }

  bool hasChild(String name) {
    return children.any((element) => element.name == name);
  }

  int size() {
    // print('Calculating size of $name');
    if (isFile) {
      return value;
    }
    if (isDir) {
      var tempSize = 0;
      for (var child in children) {
        tempSize += child.size();
      }
      return tempSize;
    }
    return -1;
  }

  bool get isFile => value != 0;

  bool get isDir => !isFile;

  String get _typeString => isFile ? 'file, size=$value' : 'dir';

  @override
  String toString() {
    return '- $name ($_typeString)';
  }
}
