import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/todo_provider.dart';
import 'add_edit_screen.dart';

// Person 7: Explain the completed tasks screen - filtering and displaying finished tasks
class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({super.key});

  Color getPriorityColor(String priority) {
    if (priority == 'High') {
      return Colors.red.shade100;
    } else if (priority == 'Medium') {
      return Colors.orange.shade100;
    } else if (priority == 'Low') {
      return Colors.green.shade100;
    } else {
      return Colors.grey.shade100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Tasks'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Consumer<TodoProvider>(
        builder: (context, provider, child) {
          List<dynamic> completedTasks = [];
          for (var task in provider.tasks) {
            if (task.isCompleted) {
              completedTasks.add(task);
            }
          }

          if (completedTasks.isEmpty) {
            return const Center(
              child: Text(
                'No completed tasks yet.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            itemCount: completedTasks.length,
            padding: const EdgeInsets.all(12),
            itemBuilder: (context, index) {
              var task = completedTasks[index];
              int originalIndex = provider.tasks.indexOf(task);

              return Card(
                color: Colors.grey.shade200,
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const Icon(Icons.check_circle,
                      color: Colors.green, size: 28),
                  title: Text(
                    task.title,
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (task.description.isNotEmpty) Text(task.description),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          task.priority,
                          style: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      provider.deleteTask(originalIndex);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Task deleted')),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
