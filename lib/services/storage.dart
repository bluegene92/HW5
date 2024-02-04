import '../model/task.dart';

abstract class Storage {
  Future<void> initialize();

  Stream<List<Task>> getTasks();
  Future<void> insertTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> removeTask(Task task);
}
