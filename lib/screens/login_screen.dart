// lib/screens/login_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../api/auth_service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      body: Center(
        child: Container(
          width: width < 800 ? width * 0.9 : 800,
          height: 500,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            gradient: const LinearGradient(
              colors: [Color(0xFFE8DAEF), Color(0xFFE3F2FD)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: width < 600
              ? _buildSinglePanel(context)
              : Row(
                  children: [
                    // Left image panel
                    Expanded(
                      child: Image.asset(
                        'assets/illustration.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 32),
                    // Right login panel
                    const Expanded(child: LoginForm()),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildSinglePanel(BuildContext context) {
    return const Center(
      child: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    final user = await AuthService.login(username, password);

    if (user != null) {
      switch (user.role) {
        case 'student':
          Navigator.pushReplacementNamed(context, '/student_dashboard');
          break;
        case 'teacher':
          Navigator.pushReplacementNamed(context, '/teacher_dashboard');
          break;
        case 'leader':
          Navigator.pushReplacementNamed(context, '/leader_dashboard');
          break;
        default:
          setState(() {
            _errorMessage = 'Unknown user role';
          });
      }
    } else {
      setState(() {
        _errorMessage = 'Invalid username or password';
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Login',
          style: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Welcome Back!',
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[700]),
        ),
        const SizedBox(height: 32),

        TextField(
          controller: _usernameController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.person),
            labelText: 'Username',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 16),

        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock),
            labelText: 'Password',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 24),

        if (_errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              _errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
          ),

        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _login,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7E57C2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: _isLoading
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : Text(
                    'Login',
                    style: GoogleFonts.poppins(
                        fontSize: 16, color: const Color.fromARGB(255, 0, 0, 0)),
                  ),
          ),
        ),
      ],
    );
  }
}
