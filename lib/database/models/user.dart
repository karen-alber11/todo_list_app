import 'package:equatable/equatable.dart';
import '../../utils/utils.dart';
import 'task.dart';  // Import the Task class

class User {
  final String id;
  final String name;
  final String email;
  final String password;

  const User({
    required this.id,  // `id` is required now, no default
    required this.name,
    required this.email,
    required this.password,
  });

  // Copy constructor to create a new User with a different `id`
  User copyWith({String? id, String? name, String? email, String? password}) {
    return User(
      id: id ?? this.id, // If `id` is passed, use it; otherwise, keep the current `id`
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      UserKeys.id: id,
      UserKeys.name: name,
      UserKeys.email: email,
      UserKeys.password: password,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json[UserKeys.id].toString(),
      name: json[UserKeys.name],
      email: json[UserKeys.email],
      password: json[UserKeys.password],
    );
  }

  @override
  List<Object?> get props => [id, name, email, password];
}

