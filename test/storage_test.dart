import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:hw4/model/task.dart';
import 'package:hw4/services/storage.dart';
import 'package:mockito/mockito.dart';

import 'mocks/mock_storage.dart';

void main() {
  late Storage mockStorage;
  late Task task;
  late List<Task> expectedTasks;

  setUp(() {
    mockStorage = MockStorage();
    task = Task(
      id: '1',
      description: 'Sample Task',
      isCompleted: false,
    );
    expectedTasks = [
      Task(id: '1', description: 'Task 1', isCompleted: false),
      Task(id: '2', description: 'Task 2', isCompleted: true),
      Task(id: '3', description: 'Task 3', isCompleted: false),
    ];
  });

  test('Make sure storage is initialized', () async {
    when(mockStorage.initialize()).thenAnswer((_) => Future.value());

    await mockStorage.initialize();

    verify(mockStorage.initialize()).called(1);
  });

  test('GetTasks returns Stream of list of Tasks', () {
    final fakeTasks = [
      Task(id: '1', description: 'Task 1', isCompleted: false),
      Task(id: '2', description: 'Task 2', isCompleted: true),
    ];

    when(mockStorage.getTasks()).thenAnswer((_) => Stream.value(fakeTasks));

    final tasksStream = mockStorage.getTasks();

    expect(tasksStream, emits(fakeTasks));
  });
}
