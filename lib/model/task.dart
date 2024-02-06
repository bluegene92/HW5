import 'package:uuid/uuid.dart';

class Task {
  static const _uuid = Uuid();
  String id;
  String description;
  bool isCompleted;
  DateTime? dueDate;

  Task({this.description = ''})
      : isCompleted = false,
        id = _uuid.v1();

  Task.toObject(
      {this.id = '',
      this.description = '',
      this.isCompleted = false,
      this.dueDate});

  //
  factory Task.fromJson(Map<String, Object?> json) {
    DateTime? dueDate;

    if (json['dueDateTimeStamp'] != null) {
      dueDate = DateTime.parse(json['dueDateTimeStamp'] as String);
    }

    return Task.toObject(
        id: json['id'] as String,
        description: json['description'] as String,
        isCompleted: json['isCompleted'] == 0 ? false : true,
        dueDate: dueDate);
  }

  //map model to json before insert to DB
  Map<String, dynamic> toJson() {
    String? dueDateAsString;

    if (dueDate != null) {
      dueDateAsString = dueDate?.toIso8601String();
    }

    return {
      'id': id,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0,
      'dueDateTimeStamp': dueDateAsString
    };
  }
}
