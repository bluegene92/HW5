import 'package:uuid/uuid.dart';

class Task {
  static const _uuid = Uuid();
  String id;
  String description;
  bool isCompleted;

  Task({this.description = ''})
      : isCompleted = false,
        id = _uuid.v1();

  Task.withComplete(
      {this.id = '', this.description = '', this.isCompleted = false});

  factory Task.fromJson(Map<String, Object?> json) => Task.withComplete(
      id: json['id'] as String,
      description: json['description'] as String,
      isCompleted: (json['isCompleted'] == 1 ? true : false));

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0
    };
  }
}
