import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/student_dashboard.dart';
import 'screens/teacher_dashboard.dart';
import 'screens/leader_dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your App',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/student_dashboard': (context) => const StudentDashboard(),
        '/teacher_dashboard': (context) => const TeacherDashboard(),
        '/leader_dashboard': (context) => const LeaderDashboard(),
      },
    );
  }
}
