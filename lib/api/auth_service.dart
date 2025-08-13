// lib/api/auth_service.dart

import '../models/users.dart';

class User {
  final String username; // Stores username
  final String role; // Stores role (student, teacher, leader)

  User({required this.username, required this.role});
}

class AuthService {
  /// Simulates login using mock users list, returns User if success or null if fail
  static Future<User?> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // Fake network delay to be extra

    try {
      // Find a user with matching username and password
      final matchedUser = mockUsers.firstWhere(
        (user) =>
            user['username'] == username && user['password'] == password,
        orElse: () => {}, // Return empty map if not found
      );

      // If user was found, return a user object
      if (matchedUser.isNotEmpty) {
        return User(
          username: matchedUser['username']!,
          role: matchedUser['role']!,
        );
      }
      return null; // Login failed
    } catch (e) {
      return null; // Something went wrong
    }
  }
}
