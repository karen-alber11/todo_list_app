import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../database/data.dart';

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final taskDatasource = ref.read(taskDatasourceProvider); // Read TaskDatasource
  return TaskRepositoryImpl(taskDatasource); // Provide TaskDatasource to TaskRepository
});
