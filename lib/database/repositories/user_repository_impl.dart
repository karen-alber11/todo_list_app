import '../../database/data.dart';
import '../../providers/providers.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDatasource _datasource;
  final TaskDatasource _taskDatasource;

  UserRepositoryImpl(this._datasource, this._taskDatasource);

  @override
  Future<void> addUser(User user) async {
    try {
      await _datasource.createUser(user);
    } catch (e) {
      throw Exception("Failed to add user: $e");
    }
  }

  @override
  Future<void> updateUser(User user) async {
    try {
      await _datasource.updateUser(user);
    } catch (e) {
      throw Exception("Failed to update user: $e");
    }
  }

  @override
  Future<void> deleteUser(User user) async {
    try {
      await _datasource.deleteUser(user.id!);  // Pass user.id
    } catch (e) {
      throw Exception("Failed to delete user: $e");
    }
  }

  @override
  Future<List<User>> getAllUsers() async {
    return await _datasource.getAllUsers();
  }

  @override
  Future<List<Task>> getTasksForUser(String userId) async {
    return await _taskDatasource.getTasksForUser(userId);
  }
}
