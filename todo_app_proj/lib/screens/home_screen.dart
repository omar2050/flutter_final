import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/todo_provider.dart';
import '../../models/task_model.dart';
import 'add_edit_screen.dart';
import 'stats_screen.dart';
import 'completed_tasks_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TodoProvider>(context, listen: false).loadTasks();
    });
  }

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
    List<Widget> screens = [
      buildTasksScreen(),
      const StatsScreen(),
      const CompletedTasksScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Prioritizer'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: Colors.teal,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Completed',
          ),
        ],
      ),
      floatingActionButton: currentIndex == 0
          ? FloatingActionButton(
              backgroundColor: Colors.teal,
              child: const Icon(Icons.add, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddEditScreen()),
                );
              },
            )
          : null,
    );
  }

  Widget buildTasksScreen() {
    return Consumer<TodoProvider>(
      builder: (context, provider, child) {
        if (provider.tasks.isEmpty) {
          return const Center(
            child: Text(
              'No tasks yet.\nAdd one to get started!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          itemCount: provider.tasks.length,
          padding: const EdgeInsets.all(12),
          itemBuilder: (context, index) {
            Task task = provider.tasks[index];
            return Dismissible(
              key: ValueKey('${task.title}-${task.createdAt.toString()}'),
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (_) async {
                await provider.deleteTask(index);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Task deleted')),
                  );
                }
              },
              child: Card(
                color: task.isCompleted
                    ? Colors.grey.shade200
                    : getPriorityColor(task.priority),
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: Checkbox(
                    activeColor: Colors.teal,
                    value: task.isCompleted,
                    onChanged: (bool? value) {
                      Task updatedTask = Task(
                        title: task.title,
                        description: task.description,
                        priority: task.priority,
                        isCompleted: value!,
                        createdAt: task.createdAt,
                      );
                      provider.updateTask(index, updatedTask);
                    },
                  ),
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration:
                          task.isCompleted ? TextDecoration.lineThrough : null,
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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  AddEditScreen(task: task, index: index),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          bool? confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Task'),
                              content: const Text(
                                  'Are you sure you want to delete this task?'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          );

                          if (confirm == true) {
                            provider.deleteTask(index);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Task deleted')),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
