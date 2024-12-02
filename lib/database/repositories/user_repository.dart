import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../database/data.dart';

abstract class UserRepository {
  Future<void> addUser(User user);
  Future<void> updateUser(User user);
  Future<void> deleteUser(User user);
  Future<List<User>> getAllUsers();
  Future<List<Task>> getTasksForUser(String userId);
}
