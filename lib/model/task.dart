import 'package:uuid/uuid.dart';

class Task {
  static const _uuid = Uuid();
  String taskId;
  String description;
  bool isCompleted;

  Task({this.description = ''})
      : isCompleted = false,
        taskId = _uuid.v1();

  Task.withComplete(
      {this.taskId = '', this.description = '', this.isCompleted = false});

  factory Task.fromJson(Map<String, Object?> json) => Task.withComplete(
      taskId: json['taskId'] as String,
      description: json['description'] as String,
      isCompleted: json['isCompleted'] as bool);

  Map<String, dynamic> toJson() {
    return {
      'taskId': taskId,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0
    };
  }
}
