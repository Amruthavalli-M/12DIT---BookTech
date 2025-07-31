// lib/api/auth_service.dart

import '../models/users.dart';

class User {
  final String username;
  final String role;

  User({required this.username, required this.role});
}

class AuthService {
  /// Simulates login with mockUsers, returns User if success or null if fail
  static Future<User?> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // simulate network delay

    try {
      final matchedUser = mockUsers.firstWhere(
        (user) =>
            user['username'] == username && user['password'] == password,
        orElse: () => {},
      );
      if (matchedUser.isNotEmpty) {
        return User(
          username: matchedUser['username']!,
          role: matchedUser['role']!,
        );
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
