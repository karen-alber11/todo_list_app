import 'package:flutter/foundation.dart' show immutable;

@immutable
class TaskKeys {
  const TaskKeys._();

  // Existing task-related keys
  static const String id = 'id';
  static const String title = 'title';
  static const String category = 'category';
  static const String date = 'date';
  static const String time = 'time';
  static const String note = 'note';
  static const String isCompleted = 'isCompleted';

  // New field to link task to user
  static const String userId = 'userId'; // Link to the user table's ID
}
