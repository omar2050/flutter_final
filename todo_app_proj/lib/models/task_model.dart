import 'package:hive/hive.dart';

class Task {
  String title;
  String description;
  String priority;
  bool isCompleted;
  DateTime createdAt;

  Task({
    required this.title,
    required this.description,
    required this.priority,
    this.isCompleted = false,
    required this.createdAt,
  });
}

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 0;

  @override
  Task read(BinaryReader reader) {
    int numFields = reader.readByte();
    Map<int, dynamic> fields = {};
    for (int i = 0; i < numFields; i++) {
      int key = reader.readByte();
      fields[key] = reader.read();
    }
    return Task(
      title: fields[0] as String,
      description: fields[1] as String,
      priority: fields[2] as String,
      isCompleted: fields[3] as bool,
      createdAt: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer.writeByte(5);
    writer.writeByte(0);
    writer.write(obj.title);
    writer.writeByte(1);
    writer.write(obj.description);
    writer.writeByte(2);
    writer.write(obj.priority);
    writer.writeByte(3);
    writer.write(obj.isCompleted);
    writer.writeByte(4);
    writer.write(obj.createdAt);
  }
}
