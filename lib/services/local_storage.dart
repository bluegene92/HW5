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
  dueDateTimeStamp TEXT NULL
);
''');

    return db.execute(''' 
  INSERT INTO $_tasksTable (id, description, dueDateTimeStamp)
  VALUES ("FAKEUIDID", "Testing 123", NULL)
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
    return _database.insert(_tasksTable, task.toJson());
  }

  @override
  Future<int> removeTask(Task task) async {
    return _database.delete(_tasksTable, where: 'id = ?', whereArgs: [task.id]);
  }
}
