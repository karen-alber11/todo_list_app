import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../database/data.dart';
import '../../providers/providers.dart';

// UserNotifier: Manages the state of users and current logged-in user
class UserNotifier extends StateNotifier<UserState> {
  final UserRepository _repository;

  // Constructor for UserNotifier
  UserNotifier(this._repository) : super(UserState.initial()) {
    getUsers();  // Fetch users on initialization
  }

  // Create a new user
  Future<void> createUser(User user, StateNotifierProviderRef ref) async {
    try {
      await _repository.addUser(user);
      getUsers();  // Fetch all users after adding

      // Set the created user as the current user
      ref.read(currentUserProvider.notifier).state = user;
    } catch (e) {
      print(e.toString());  // Use print for error logging
    }
  }

  // Fetch all users from the repository
  Future<void> getUsers() async {
    try {
      final users = await _repository.getAllUsers();
      state = state.copyWith(users: users);  // Update the state with new users
    } catch (e) {
      print(e.toString());  // Error handling
    }
  }

  // Update a user's details
  Future<void> updateUser(User user) async {
    try {
      await _repository.updateUser(user);
      getUsers();  // Fetch updated list of users
    } catch (e) {
      print(e.toString());  // Error handling
    }
  }

  // Delete a user
  Future<void> deleteUser(User user) async {
    try {
      await _repository.deleteUser(user);
      getUsers();  // Fetch users again after deleting
    } catch (e) {
      print(e.toString());  // Error handling
    }
  }

  // Set the current user (login)
  Future<void> setCurrentUser(User user, StateNotifierProviderRef ref) async {
    ref.read(currentUserProvider.notifier).state = user;  // Set the logged-in user
  }

  // Clear the current user (logout)
  Future<void> clearCurrentUser(StateNotifierProviderRef ref) async {
    ref.read(currentUserProvider.notifier).state = null;  // Clear the current user
  }
}
