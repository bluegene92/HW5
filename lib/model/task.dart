import 'package:uuid/uuid.dart';

class Task {
  Task({this.description = '', String? id})
      : isCompleted = false,
        id = id ?? _uuid.v1();
  bool isCompleted;
  static const _uuid = Uuid();
  final String description;
  final String id;

  factory Task.fromJson(Map<String, Object?> json) => Task(
        id: json['id'] as String,
        description: json['description'] as String,
      );

  Map<String, dynamic> toJson() {
    return {'id': id, 'description': description, 'isCompleted': isCompleted};
  }
}
