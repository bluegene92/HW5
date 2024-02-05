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

  @override
  Future<void> initialize() async {
    final name = join(await getDatabasesPath(), 'todo.db');
    await deleteDatabase(name);

    final database = await openDatabase(
      name,
      onCreate: _onCreate,
      version: 1,
    );

    _database = BriteDatabase(database);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE $_tasksTable (
  task_id INTEGER PRIMARY KEY AUTOINCREMENT,
  id TEXT NOT NULL,
  description TEXT NOT NULL,
  isCompleted INTEGER NOT NULL DEFAULT 0,
  dueDateTimeStamp INTEGER NULL
);
''');

    return db.execute(''' 
  INSERT INTO $_tasksTable (id, description, isCompleted, dueDateTimeStamp)
  VALUES ("FAKEUIDID", "Testing 123", 0, NULL)
  ''');
  }

  @override
  Stream<List<Task>> getTasks() {
    return _database
        .createQuery(_tasksTable)
        .mapToList((e) => Task.fromJson(e));
  }

  @override
  Future<int> insertTask(Task task) async {
    await _database.insert(_tasksTable, task.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return Future.value(0);
  }

  @override
  Future<int> removeTask(Task task) async {
    await _database.delete(_tasksTable, where: 'id = ?', whereArgs: [task.id]);
    return Future.value(0);
  }

  @override
  Future<int> updateTask(Task task) async {
    task.isCompleted = !task.isCompleted;
    await _database.update(_tasksTable, task.toJson(),
        where: 'id = ?', whereArgs: [task.id]);

    return Future.value(0);
  }
}
