import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../database/datasource/datasource.dart';

final taskDatasourceProvider = Provider<TaskDatasource>((ref) {
  return TaskDatasource();
});
