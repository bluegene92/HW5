class Task {
  String id;
  String description;
  bool isCompleted;
  DateTime? dueDate;

  Task(
      {this.id = '',
      this.description = '',
      this.isCompleted = false,
      this.dueDate});

  Task.toObject(
      {this.id = '',
      this.description = '',
      this.isCompleted = false,
      this.dueDate});

  //
  factory Task.fromJson(Map<String, dynamic> json) {
    DateTime? dueDate;

    if (json['dueDateTimeStamp'] != null) {
      dueDate = DateTime.parse(json['dueDateTimeStamp'] as String);
    }

    return Task.toObject(
        id: json['id'] as String,
        description: json['description'] as String,
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
      'dueDateTimeStamp': dueDateAsString
    };
  }
}
