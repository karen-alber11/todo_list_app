import 'package:flutter/foundation.dart' show immutable;

@immutable
class AppKeys {
  const AppKeys._();

  // Existing keys
  static const String isDarkMode = 'isDarkMode';
  static const String dbTable = 'tasks';

  // New keys for users and tasks
  static const String usersTable = 'users'; // Table name for users
  static const String tasksTable = 'tasks'; // Table name for tasks

  // Add user-related constants
  static const String userId = 'userId'; // User ID in tasks table
}
