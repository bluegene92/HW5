import 'package:uuid/uuid.dart';

class Task {
  Task({this.description = '', String? id})
      : isCompleted = false,
        taskId = id ?? _uuid.v1();
  bool isCompleted;
  static const _uuid = Uuid();
  final String description;
  final String taskId;

  factory Task.fromJson(Map<String, Object?> json) => Task(
        id: json['id'] as String,
        description: json['description'] as String,
      );

  Map<String, dynamic> toJson() {
    return {
      'taskId': taskId,
      'description': description,
      'isCompleted': isCompleted
    };
  }
}
