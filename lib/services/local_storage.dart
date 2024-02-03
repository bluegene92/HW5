import 'dart:async';

import 'package:path/path.dart';
import 'package:sqlbrite/sqlbrite.dart';

import '../model/task.dart';
import 'storage.dart';

class LocalStorage implements Storage {
  factory LocalStorage() => _singleton;

  LocalStorage._internal();

  static final _singleton = LocalStorage._internal();
  static const _tasksTable = 'Task';

  late BriteDatabase _database;
  final _streamController = StreamController<List<Task>>();

  @override
  Future<void> initialize() async {
    final name = join(await getDatabasesPath(), 'todo.db');
    // await deleteDatabase(name);

    final database = await openDatabase(
      name,
      onCreate: _onCreate,
      version: 1,
    );

    _database = BriteDatabase(database);
  }

  static Future<void> _onCreate(Database db, int version) async {
    await deleteDatabase(_tasksTable);

    await db.execute('''
    CREATE TABLE $_tasksTable (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    taskId String NOT NULL,
    description TEXT NOT NULL,
    isComplete INTEGER DEFAULT 0
    )
    ''');
  }

  @override
  Stream<List<Task>> getTasks() {
    return _database.createQuery(_tasksTable).mapToList((e) => Task());
  }

  @override
  Future<int> insertTask(String description) async {
    var newTask = Task(description: description);

    print(newTask);
    _database.insert(_tasksTable, newTask.toJson());
    List<Task> list = [newTask];
    _streamController.add(list);

    print('add {newTask}');
    return Future.value(0);
  }

  @override
  Future<int> removeTask(Task task) {
    // TODO
    return Future.value(0);
  }
}
