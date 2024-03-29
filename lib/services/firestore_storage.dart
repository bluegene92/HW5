import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;

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

    return _db
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
    if (_userId == null) return Future.value();

    Timestamp? dueDateTimeStamp;
    if (task.dueDate != null) {
      dueDateTimeStamp = Timestamp.fromDate(task.dueDate!);
    }

    return _db
        .collection(_users)
        .doc(_auth.userId)
        .collection(_tasks)
        .add({_description: task.description, _dueDate: dueDateTimeStamp});
  }

  @override
  Future<void> removeTask(Task task) {
    if (_userId == null) return Future.value();

    return _db
        .collection(_users)
        .doc(_auth.userId)
        .collection(_tasks)
        .doc(task.id)
        .delete();
  }
}
