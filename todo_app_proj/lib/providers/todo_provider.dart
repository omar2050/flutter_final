import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/task_model.dart';

// Person 3: Explain the TodoProvider - manages all task operations and state
class TodoProvider extends ChangeNotifier {
  static const String boxName = 'tasksBox';
  List<Task> tasks = [];

  // Person 3: This loads tasks from storage and sorts them (pending first, then completed)
  Future<void> loadTasks() async {
    final box = await Hive.openBox<Task>(boxName);
    tasks = box.values.toList();
    tasks.sort((a, b) {
      if (a.isCompleted != b.isCompleted) {
        return a.isCompleted ? 1 : -1;
      }
      return b.createdAt.compareTo(a.createdAt);
    });
    notifyListeners();
  }

  Future<void> addTask(
      String title, String description, String priority) async {
    final box = await Hive.openBox<Task>(boxName);
    final newTask = Task(
      title: title,
      description: description,
      priority: priority,
      createdAt: DateTime.now(),
    );
    await box.add(newTask);
    await loadTasks();
  }

  // Person 3: Update an existing task and reload from storage
  Future<void> updateTask(int index, Task task) async {
    final box = await Hive.openBox<Task>(boxName);
    await box.putAt(index, task);
    await loadTasks();
  }

  // Person 3: Delete a task from storage
  Future<void> deleteTask(int index) async {
    final box = await Hive.openBox<Task>(boxName);
    await box.deleteAt(index);
    await loadTasks();
  }
}
