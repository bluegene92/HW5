import 'package:hw4/services/firestore_storage.dart';
import '../model/task.dart';

class TaskController {
  factory TaskController() => _singleton;

  TaskController._internal();

  static final TaskController _singleton = TaskController._internal();

  //final Storage _storage = CachedStorage();
  //final LocalStorage _localStorage = LocalStorage();
  final FirestoreStorage _firestoreStorage = FirestoreStorage();

  Stream<List<Task>> getStream() => _firestoreStorage.getTasks();

  Future<void> insertTask(Task task) => _firestoreStorage.insertTask(task);

  Future<void> removeTask(Task task) => _firestoreStorage.removeTask(task);

  Future<void> initialize() => _firestoreStorage.initialize();
}
