import 'package:hive/hive.dart';

import '../model/task.dart';

class TaskViewModel {
  static const String _taskBox = 'taskBox';
  late Box _box;

  TaskViewModel() {
    _init();
  }

  Future<void> _init() async {
    _box = await Hive.openBox(_taskBox);
  }

  Future<List<Task>> getTasks(bool isCompleted) async {
    final tasks = _box.values
        .map((e) => Task.fromMap(Map<String, dynamic>.from(e)))
        .where((task) => task.isCompleted == isCompleted)
        .toList();
    return tasks;
  }

  Future<void> addTask(Task task) async {
    await _box.put(task.id, task.toMap());
  }

  Future<void> updateTask(Task task) async {
    await _box.put(task.id, task.toMap());
  }

  Future<void> deleteTask(String id) async {
    await _box.delete(id);
  }
}
