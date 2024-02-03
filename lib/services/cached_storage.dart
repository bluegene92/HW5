import 'dart:async';

import '../model/task.dart';
import 'storage.dart';

class CachedStorage implements Storage {
  factory CachedStorage() => _singleton;

  CachedStorage._internal();

  static final CachedStorage _singleton = CachedStorage._internal();

  final streamController = StreamController<List<Task>>();

  final _data = [
    Task(description: 'Task 1'),
    Task(description: 'Task 2'),
    Task(
        description:
            'This is a longer task that requires you to wrap the text to a new line and to make sure that the visuals handle that correctly.'),
    Task(description: 'Task 4'),
  ];

  @override
  Stream<List<Task>> getTasks() {
    streamController.add(_data);
    return streamController.stream;
  }

  @override
  Future<Task> insertTask(String description) {
    final newTask = Task(description: description);
    _data.add(newTask);
    streamController.add(_data);
    return Future.value(newTask);
  }

  @override
  Future<bool> removeTask(Task task) {
    final changed = _data.remove(task);
    if (changed) {
      streamController.add(_data);
    }
    return Future.value(changed);
  }

  @override
  Future<void> initialize() => Future.value();
}
