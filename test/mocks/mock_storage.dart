import 'dart:ffi';

import 'package:hw4/model/task.dart';
import 'package:hw4/services/storage.dart';
import 'package:mockito/mockito.dart';

class MockStorage extends Mock implements Storage {
  final fakeTasks = [
    Task(id: '1', description: 'Task 1', isCompleted: false),
    Task(id: '2', description: 'Task 2', isCompleted: true),
    Task(id: '3', description: 'Task 3', isCompleted: false),
  ];

  @override
  Future<void> initialize() {
    return super.noSuchMethod(Invocation.method(#initialize, []),
        returnValue: Future.value());
  }

  @override
  Stream<List<Task>> getTasks() {
    return super.noSuchMethod(Invocation.method(#getTasks, []),
        returnValue: Stream.value(fakeTasks.toList()));
  }

  @override
  Future<void> insertTasks(Task task) {
    return super.noSuchMethod(Invocation.method(#insertTasks, [task]),
        returnValue: Future.value());
  }

  @override
  Future<void> removeTask(Task task) {
    return super.noSuchMethod(Invocation.method(#removeTask, [task]),
        returnValue: Future.value());
  }
}
