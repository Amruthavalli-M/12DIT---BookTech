// lib/screens/login_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // For custom fonts styling
import '../api/auth_service.dart'; // Backend service for authentication

// Stateless widget representing the entire login screen
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current screen width for responsive layout
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED), // Light grey background for the whole screen

      // Center content vertically and horizontally
      body: Center(
        // Container that holds either the image + form side-by-side or just form (depending on width)
        child: Container(
          // Width adjusts to 90% of screen on narrow devices or max 800 on wider screens
          width: width < 800 ? width * 0.9 : 800,
          height: 500,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            // Rounded corners for a modern look
            borderRadius: BorderRadius.circular(32),
            // Gradient background from top-left to bottom-right with blues
            gradient: const LinearGradient(
              colors: [Color.fromARGB(255, 90, 156, 255), Color(0xFFE3F2FD)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),

          // Choose layout based on screen width
          child: width < 600
              ? _buildSinglePanel(context) // Small screens: just show the login form centered
              : Row(
                  children: [
                    // Left side: image/logo panel takes half the width
                    Expanded(
                      child: Image.asset(
                        'assets/lightlogo.png', // Path to your logo image asset
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 32), // Spacing between image and form

                    // Right side: login form takes half the width
                    const Expanded(child: LoginForm()),
                  ],
                ),
        ),
      ),
    );
  }

  // Builds a centered single panel with just the login form (used on small screen widths)
  Widget _buildSinglePanel(BuildContext context) {
    return const Center(
      child: LoginForm(),
    );
  }
}

// Stateful widget representing the login form itself
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // Controllers to get text input values for username and password
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // Track loading state during login process (to disable button and show spinner)
  bool _isLoading = false;

  // Holds error messages to show below form if login fails
  String? _errorMessage;

  @override
  void dispose() {
    // Dispose controllers when widget is removed to free resources
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Function to attempt login using AuthService with current input values
  Future<void> _login() async {
    setState(() {
      _isLoading = true; // Show loading spinner
      _errorMessage = null; // Clear previous errors
    });

    // Get trimmed username and password from input fields
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    // Call the AuthService login method, which returns a user object on success
    final user = await AuthService.login(username, password);

    if (user != null) {
      // Successful login: route user based on their role
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
          // If role is unknown, show error message
          setState(() {
            _errorMessage = 'Unknown user role';
          });
      }
    } else {
      // Login failed: show error message
      setState(() {
        _errorMessage = 'Invalid username or password';
      });
    }

    setState(() {
      _isLoading = false; // Hide loading spinner after attempt completes
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // Center vertically inside parent
      children: [
        // Large title text 'Login'
        Text(
          'Login',
          style: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8), // Small spacing

        // Subtitle/welcome text
        Text(
          'Welcome Back!',
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[700]),
        ),
        const SizedBox(height: 32),

        // Username input field
        TextField(
          controller: _usernameController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.person), // User icon before input
            labelText: 'Username',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 16),

        // Password input field, obscured text for privacy
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock), // Lock icon before input
            labelText: 'Password',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 24),

        // If there is an error message, display it here in red
        if (_errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              _errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
          ),

        // Login button that fills the width
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            // Disable button if loading is true to prevent multiple clicks
            onPressed: _isLoading ? null : _login,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7E57C2), // Purple button color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            // Show spinner or text depending on loading state
            child: _isLoading
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : Text(
                    'Login',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
