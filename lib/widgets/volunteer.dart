import 'package:flutter/material.dart';

class VolunteerWidget extends StatelessWidget {
  const VolunteerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Empty for now, add content later
    return Container(
      height: 200,
      color: Colors.green[50],
      child: const Center(
        child: Text(
          'Volunteer Coming Soon',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
