import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/todo_provider.dart';
import '../../models/task_model.dart';

// Person 6: Explain the form screen for creating and editing tasks
class AddEditScreen extends StatefulWidget {
  final Task? task;
  final int? index;

  const AddEditScreen({super.key, this.task, this.index});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String selectedPriority = 'Medium';

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      titleController.text = widget.task!.title;
      descriptionController.text = widget.task!.description;
      selectedPriority = widget.task!.priority;
    }
  }

  // Person 6: Form with title input, description input, and priority dropdown
  @override
  Widget build(BuildContext context) {
    String pageTitle = widget.task == null ? 'New Task' : 'Edit Task';
    String buttonText = widget.task == null ? 'Create Task' : 'Save Changes';

    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Task Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description (Optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedPriority,
                decoration: const InputDecoration(
                  labelText: 'Priority Level',
                  border: OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem(value: 'High', child: const Text('High')),
                  DropdownMenuItem(
                      value: 'Medium', child: const Text('Medium')),
                  DropdownMenuItem(value: 'Low', child: const Text('Low')),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedPriority = value!;
                  });
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    saveTask();
                  }
                },
                child: Text(buttonText),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Person 6: Save new task or update existing task by calling Provider methods
  void saveTask() {
    TodoProvider provider = Provider.of<TodoProvider>(context, listen: false);
    String title = titleController.text;
    String description = descriptionController.text;
    String priority = selectedPriority;

    if (widget.task == null) {
      provider.addTask(title, description, priority);
    } else {
      Task newTask = Task(
        title: title,
        description: description,
        priority: priority,
        isCompleted: widget.task!.isCompleted,
        createdAt: widget.task!.createdAt,
      );
      provider.updateTask(widget.index!, newTask);
    }
    Navigator.pop(context);
  }
}
