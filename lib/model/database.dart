import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';

class Database {
  var myBox = Hive.box("todolist");

List tasks = [];

  void addTask(Map<String, dynamic> task) {
    myBox.add(task);
    refresh();
  }

  void refresh() {
    var data = myBox.keys.map((key) {
      var task = myBox.get(key);
      return {"key":  key, "title": task["title"], "description": task["description"]};
    }).toList();
    tasks = data;
  }

  void updateTask(int id, Map<String, dynamic> task) {
    myBox.put(id, task);
    refresh();
  }

  void deleteTask(int id) {
    myBox.delete(id);
    refresh();
  }
}