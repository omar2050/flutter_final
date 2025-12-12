import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/task_model.dart';

class TodoProvider extends ChangeNotifier {
  static const String boxName = 'tasksBox';

  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;
  Future<void> loadTasks() async {
    final box = await Hive.openBox<Task>(boxName);
    _tasks = box.values.toList();
    _tasks.sort((a, b) {
      if (a.isCompleted == b.isCompleted) {
        return b.createdAt.compareTo(a.createdAt);
      }
      return a.isCompleted ? 1 : -1;
    });
    notifyListeners();
  }

  Future<void> addTask(String title, String desc, String priority) async {
    final box = await Hive.openBox<Task>(boxName);

    final newTask = Task(
      title: title,
      description: desc,
      priority: priority,
      createdAt: DateTime.now(),
    );

    await box.add(newTask);
    await loadTasks();
  }

  Future<void> updateTask(int index, Task updatedTask) async {
    final box = await Hive.openBox<Task>(boxName);
    await box.putAt(index, updatedTask);
    await loadTasks();
  }

  Future<void> deleteTask(int index) async {
    final box = await Hive.openBox<Task>(boxName);
    await box.deleteAt(index);
    await loadTasks();
  }
}
