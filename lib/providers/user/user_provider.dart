import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../database/data.dart';
import '../../providers/providers.dart';

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return UserNotifier(repository);
});

// Current User Provider to manage logged-in user
final currentUserProvider = StateProvider<User?>((ref) {
  return null;  // Initially, no user is logged in
});
