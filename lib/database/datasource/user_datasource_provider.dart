import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../database/datasource/datasource.dart';

final userDatasourceProvider = Provider<UserDatasource>((ref) {
  return UserDatasource();
});
