import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../database/data.dart';
import '../../providers/providers.dart';

final tasksProvider = StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  final taskRepository = ref.watch(taskRepositoryProvider);  // Get TaskRepository from provider
  final userRepository = ref.watch(userRepositoryProvider);  // Get UserRepository from provider
  return TaskNotifier(taskRepository, userRepository);  // Pass both repositories
});
