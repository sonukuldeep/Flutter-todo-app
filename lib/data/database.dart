import 'package:hive_flutter/adapters.dart';

class TodoDatabase {
  List todos = [];
  final _todoDB = Hive.box("todoDB");

  void _createDummyData() {
    todos = [
      [
        "Go to the Gym",
        "Cheat day today",
        false,
      ],
      [
        "Doctor's visit",
        "take health book",
        false,
      ]
    ];
  }

  void loadData() {
    var res = _todoDB.get("todos");
    if (res == null) {
      _createDummyData();
    } else {
      todos = res;
    }
  }

  void updateData() {
    _todoDB.put("todos", todos);
  }
}
