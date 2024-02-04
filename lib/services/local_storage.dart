import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';
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
    final dbPath = join(await getDatabasesPath(), 'todo.db');
    await deleteDatabase(dbPath);

    final database = await openDatabase(
      dbPath,
      onCreate: _onCreate,
      version: 1,
    );

    _database = BriteDatabase(database);
  }

  static Future<void> _onCreate(Database db, int version) async {
    try {
      await db.execute('''
      CREATE TABLE $_tasksTable (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      taskId String NOT NULL,
      description TEXT NOT NULL,
      isCompleted INTEGER DEFAULT 0
      )
      ''');
      print('create table successfully');
    } catch (e) {
      print('Unable to create table');
    }
  }

  @override
  Stream<List<Task>> getTasks() {
    return _database
        .createQuery(_tasksTable)
        .mapToList((e) => Task.fromJson(e));
  }

  @override
  Future<int> insertTask(String description) async {
    var newTask = Task(description: description);

    var taskJson = newTask.toJson();
    print('add $taskJson');
    _database.insert(_tasksTable, newTask.toJson());
    return Future.value(0);
  }

  @override
  Future<int> removeTask(Task task) {
    // TODO
    return Future.value(0);
  }
}
