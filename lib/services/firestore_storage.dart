import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/task.dart';
import 'storage.dart';

class FirestoreStorage implements Storage {
  static const _tasks = 'tasks';
  static const _description = 'description';

  @override
  Future<void> initialize() => Future.value();

  @override
  Stream<List<Task>> getTasks() {
    return FirebaseFirestore.instance
        .collection(_tasks)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        print('data $data');
        return Task(description: data['description']);
      }).toList();
    });
  }

  @override
  Future<void> insertTask(Task task) {
    Timestamp? dueDateTimeStamp;
    if (task.dueDate != null) {
      dueDateTimeStamp = Timestamp.fromDate(task.dueDate!);
    }

    return FirebaseFirestore.instance
        .collection(_tasks)
        .add({'description': task.description, 'dueDate': dueDateTimeStamp});
  }

  @override
  Future<void> removeTask(Task task) {
    return Future.value();
  }
}
