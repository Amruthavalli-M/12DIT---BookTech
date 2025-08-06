import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  /// Widget to show for mobile screens (less than 768px)
  final Widget mobile;

  /// Widget to show for tablet screens (768px - 1024px)
  final Widget? tablet;

  /// Widget to show for desktop screens (1025px and above)
  final Widget desktop;

  /// Constructor
  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  /// Returns true if screen width is less than 768px
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  /// Returns true if screen width is between 768 and 1024px
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1024 &&
      MediaQuery.of(context).size.width >= 786;
  

  /// Returns true if screen width is greater than or equal to 1025px
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1025;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    if (size.width >= 1025) {
      return desktop;
    } else if (size.width >= 768 && tablet != null) {
      return tablet!; 
    } else {
      return mobile;
    }
  }
}
