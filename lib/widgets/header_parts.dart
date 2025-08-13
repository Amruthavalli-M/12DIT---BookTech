import 'package:flutter/material.dart';

class HeaderParts extends StatelessWidget {
  // Title text passed in to show role dashboard
  final String title;

  // Title argument
  const HeaderParts({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min, // Row width wraps content 
      children: [
        SizedBox(
          // Container for the column of texts
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Align children at top vertically
            crossAxisAlignment: CrossAxisAlignment.start, // Align children to the left horizontally
            children: [
              // Large title text
              Text(
                title, 
                style: Theme.of(context).textTheme.headlineLarge,
              ),

              // Subtitle text below title, static string 
              Text(
                "Technical Committee", 
                style: Theme.of(context).textTheme.titleMedium,
              )
            ],
          ),
        ),
      ],
    );
  }
}
