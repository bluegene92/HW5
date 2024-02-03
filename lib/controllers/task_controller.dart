import 'package:hw4/services/cached_storage.dart';
import 'package:hw4/services/local_storage.dart';

import '../model/task.dart';
import '../services/storage.dart';

class TaskController {
  factory TaskController() => _singleton;

  TaskController._internal();

  static final TaskController _singleton = TaskController._internal();

  final Storage _storage = CachedStorage();
  final LocalStorage _localStorage = LocalStorage();

  Stream<List<Task>> getStream() => _localStorage.getTasks();

  Future<void> insertTask(String description) =>
      _localStorage.insertTask(description);

  Future<void> removeTask(Task task) => _storage.removeTask(task);

  Future<void> initialize() => _localStorage.initialize();
}
