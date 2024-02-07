import 'package:hw4/services/local_storage.dart';
import '../model/task.dart';

class TaskController {
  factory TaskController() => _singleton;

  TaskController._internal();

  static final TaskController _singleton = TaskController._internal();

  //final Storage _storage = CachedStorage();
  final LocalStorage _localStorage = LocalStorage();

  Stream<List<Task>> getStream() => _localStorage.getTasks();

  Future<void> insertTask(Task task) => _localStorage.insertTask(task);

  Future<void> removeTask(Task task) => _localStorage.removeTask(task);

  Future<void> initialize() => _localStorage.initialize();
}
