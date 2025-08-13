import 'package:flutter/material.dart';

class NotificationBar extends StatelessWidget {
  const NotificationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        color: Colors.amber, // amber container
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
