import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/task_model.dart';

class TodoProvider extends ChangeNotifier {
  static const String boxName = 'tasksBox';
  List<Task> tasks = [];

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
      isCompleted: false,
      createdAt: DateTime.now(),
    );
    await box.add(newTask);
    await loadTasks();
  }

  Future<void> updateTask(int index, Task task) async {
    final box = await Hive.openBox<Task>(boxName);

    Task originalTask = tasks[index];
    int actualIndex = -1;

    for (int i = 0; i < box.length; i++) {
      Task? boxTask = box.getAt(i);
      if (boxTask != null &&
          boxTask.title == originalTask.title &&
          boxTask.description == originalTask.description &&
          boxTask.priority == originalTask.priority &&
          boxTask.createdAt == originalTask.createdAt) {
        actualIndex = i;
        break;
      }
    }

    if (actualIndex != -1) {
      await box.putAt(actualIndex, task);
    }
    await loadTasks();
  }

  Future<void> deleteTask(int index) async {
    final box = await Hive.openBox<Task>(boxName);

    Task originalTask = tasks[index];
    int actualIndex = -1;

    for (int i = 0; i < box.length; i++) {
      Task? boxTask = box.getAt(i);
      if (boxTask != null &&
          boxTask.title == originalTask.title &&
          boxTask.description == originalTask.description &&
          boxTask.priority == originalTask.priority &&
          boxTask.createdAt == originalTask.createdAt) {
        actualIndex = i;
        break;
      }
    }

    if (actualIndex != -1) {
      await box.deleteAt(actualIndex);
    }
    await loadTasks();
  }
}
