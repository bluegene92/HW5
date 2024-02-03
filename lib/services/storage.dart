import '../model/task.dart';

abstract class Storage {
  Future<void> initialize();

  Stream<List<Task>> getTasks();
  Future<void> insertTask(String description);
  Future<void> removeTask(Task task);
}
