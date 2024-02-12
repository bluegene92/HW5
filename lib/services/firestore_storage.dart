import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/task.dart';
import 'storage.dart';

class FirestoreStorage implements Storage {
  static const _tasks = 'tasks';
  static const _description = 'description';
  static const _dueDate = 'dueDate';

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
        DateTime? dueDate;

        if (data[_dueDate] != null) {
          dueDate = data[_dueDate].toDate() as DateTime;
        }

        // print("data ${doc.id} ${data}");

        return Task(
            id: doc.id, description: data[_description], dueDate: dueDate);
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
        .add({_description: task.description, _dueDate: dueDateTimeStamp});
  }

  @override
  Future<void> removeTask(Task task) {
    return FirebaseFirestore.instance.collection(_tasks).doc(task.id).delete();
  }
}
