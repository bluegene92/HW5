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
    int? dueDateTimeStamp;
    if (json['dueDateTimeStamp'] != null) {
      dueDateTimeStamp = json['dueDateTimeStamp'] as int;
    }

    //convert seconds to milliseconds, then to DateTime
    // DateTime dueDate =
    //     DateTime.fromMillisecondsSinceEpoch(dueDateTimeStamp * 1000);

    return Task.toObject(
        id: json['id'] as String,
        description: json['description'] as String,
        isCompleted: (json['isCompleted'] == 1 ? true : false),
        dueDate: dueDateTimeStamp != null ? DateTime.now() : null);
  }

  Map<String, dynamic> toJson() {
    // int? dueDateInSeconds;

    // if (dueDate != null) {
    //   dueDateInSeconds = dueDate?.millisecondsSinceEpoch ?? 0 ~/ 1000;
    // }

    return {
      'id': id,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }
}
