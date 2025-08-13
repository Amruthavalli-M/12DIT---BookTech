import 'package:flutter/material.dart';


/// SizeConfig helps with responsive design
/// Calculates screen dimensions and block sizes to scale UI elements
class SizeConfig {
  // Stores MediaQueryData for the current context
  static late MediaQueryData _mediaQueryData;

  // Width of device screen in pixels
  static late double screenWidth;

  // Height of the device screen in pixels
  static late double screenHeight;

  // 1% of screen width (unit)
  static late double blockSizeHorizontal;

  // 1% of screen height (unit)
  static late double blockSizeVertical;

  /// Initialises the SizeConfig values based on BuildContext
  /// Called at start of screen

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context); // Get current screen info
    screenWidth = _mediaQueryData.size.width; // Set screen width
    screenHeight = _mediaQueryData.size.height; // Set screen height
    blockSizeHorizontal = screenWidth / 100; // Calculate horizontal 1% block
    blockSizeVertical = screenHeight /100; // Calculate vertical 1% block
  }
}
