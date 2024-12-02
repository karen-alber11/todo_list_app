import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../database/data.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final userDatasource = ref.read(userDatasourceProvider);
  final taskDatasource = ref.read(taskDatasourceProvider);
  return UserRepositoryImpl(userDatasource, taskDatasource);
});
