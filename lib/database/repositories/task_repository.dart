import '../../database/data.dart';

abstract class TaskRepository {
  Future<void> addTask(Task task);
  Future<void> deleteTask(Task task);
  Future<void> updateTask(Task task);
  Future<List<Task>> getAllTasks();
  Future<List<Task>> getTasksForUser(String userId);
}
