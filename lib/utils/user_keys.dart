import 'package:flutter/foundation.dart' show immutable;

@immutable
class UserKeys {
  static const String id = 'id'; // ID of the user
  static const String name = 'name'; // Name of the user
  static const String email = 'email'; // Email of the user
  static const String password = 'password'; // Password of the user (store securely)
}
