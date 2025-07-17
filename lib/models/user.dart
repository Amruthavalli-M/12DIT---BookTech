class User {
  final String username;
  final String name;
  final String role;

  User({required this.username, required this.name, required this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? '',
    );
  }
}