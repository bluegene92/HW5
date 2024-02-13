import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../controllers/auth_controller.dart';
import '../model/task.dart';
import 'storage.dart';

class FirestoreStorage implements Storage {
  static const _users = 'users';
  static const _tasks = 'tasks';
  static const _description = 'description';
  static const _dueDate = 'dueDate';

  final _db = FirebaseFirestore.instance;
  final _auth = AuthController();
  final _userId = AuthController().userId;

  @override
  Future<void> initialize() => Future.value();

  @override
  Stream<List<Task>> getTasks() {
    if (_userId == null) {
      final controller = StreamController<List<Task>>();
      controller.close();
      return controller.stream;
    }

    return FirebaseFirestore.instance
        .collection(_users)
        .doc(_auth.userId)
        .collection(_tasks)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        DateTime? dueDate;

        if (data[_dueDate] != null) {
          dueDate = data[_dueDate].toDate() as DateTime;
        }

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

    if (_auth.userId == null) {
      throw Exception('User is not logged in');
    }

    return FirebaseFirestore.instance
        .collection(_users)
        .doc(_auth.userId)
        .collection(_tasks)
        .add({_description: task.description, _dueDate: dueDateTimeStamp});
  }

  @override
  Future<void> removeTask(Task task) {
    return FirebaseFirestore.instance
        .collection(_users)
        .doc(_auth.userId)
        .collection(_tasks)
        .doc(task.id)
        .delete();
  }
}
