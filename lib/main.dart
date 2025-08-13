import 'package:booktech_flutter/utils/theme.dart';
import 'package:flutter/material.dart';
// Import different screen files for navigation
import 'screens/login_screen.dart';
import 'screens/student_dashboard.dart';
import 'screens/teacher_dashboard.dart';
import 'screens/leader_dashboard.dart';

// Entry point of the Flutter application
void main() {
  runApp(const MyApp()); // Runs the MyApp widget
}

// Root widget of the app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Removes the debug banner from the top right corner
      debugShowCheckedModeBanner: false,

      // Title of the app 
      title: 'Technical Committee App',

      // Sets the default theme (blue color scheme)
      theme: MyAppTheme.lightTheme,

      // First screen to be displayed when the app starts
      initialRoute: '/',

      // Named routes for navigation between pages
      routes: {
        '/': (context) => const LoginScreen(), // Login page
        '/student_dashboard': (context) => StudentDashboard(), // Student dashboard
        '/teacher_dashboard': (context) => TeacherDashboard(), // Teacher dashboard
        '/leader_dashboard': (context) => LeaderDashboard(),   // Leader dashboard
      },
    );
  }
}
