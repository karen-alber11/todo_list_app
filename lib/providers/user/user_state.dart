import 'package:equatable/equatable.dart';
import '../../database/data.dart';

class UserState extends Equatable {
  final List<User> users;

  // Constructor with named parameter
  const UserState({
    required this.users,
  });

  // Default initial state with empty list of users
  const UserState.initial() : users = const [];

  // Method to create a new state with updated properties (copyWith)
  UserState copyWith({
    List<User>? users,
  }) {
    return UserState(
      users: users ?? this.users, // If users is not provided, retain existing users
    );
  }

  @override
  List<Object> get props => [users];  // Equatable comparison based on users list
}
