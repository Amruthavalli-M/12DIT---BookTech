import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      body: width < 600
          ? const Center(child: _LoginForm()) // Mobile layout
          : Row( // Wide layout
              children: [
                // Left side: Image
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Image.asset(
                      'assets/illustration.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                // Right side: Login form
                Expanded(
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 400),
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: const _LoginForm(),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
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

        // Username field
        TextField(
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.person),
            labelText: 'Username',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Password field
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock),
            labelText: 'Password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Login button
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7E57C2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Login',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
