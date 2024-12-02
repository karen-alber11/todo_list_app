import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../database/data.dart';
import '../../providers/providers.dart';

class TaskNotifier extends StateNotifier<TaskState> {
  final TaskRepository _repository;
  final UserRepository _userRepository;

  TaskNotifier(this._repository, this._userRepository) : super(const TaskState.initial()) {
    getTasks();
  }

  // Create a new task for a specific user
  Future<void> createTask(String userId, Task task) async {
    try {
      // Convert userId to int before saving
      // final int userIdInt = int.parse(userId); // Ensure userId is valid
      await _repository.addTask(task.copyWith(userId: userId));
      getTasks();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // Delete a task
  Future<void> deleteTask(Task task) async {
    try {
      await _repository.deleteTask(task);
      getTasks();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // Update the task's completion status
  Future<void> updateTask(Task task) async {
    try {
      final isCompleted = !task.isCompleted;
      final updatedTask = task.copyWith(isCompleted: isCompleted);
      await _repository.updateTask(updatedTask);
      getTasks();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // Fetch tasks associated with a specific user
  Future<void> getTasks() async {
    final userId = '1';
    try {
      final tasks = await _repository.getTasksForUser(userId);
      state = state.copyWith(tasks: tasks);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // Fetch tasks by userId (added this method to match the expected call)
  Future<List<Task>> getTasksByUserId(String userId) async {
    return await _repository.getTasksForUser(userId);
  }
}
