import 'package:flutter/widgets.dart';

class ResponsiveSize {
  static late double screenWidth;
  static late double screenHeight;

  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
  }

  static double height(double size) {
    const double referenceHeight = 812.0;
    return (size * (screenHeight / referenceHeight)).clamp(0.0, screenHeight);
  }

  static double width(double size) {
    const double referenceWidth = 375.0;
    return (size * (screenWidth / referenceWidth)).clamp(0.0, screenWidth);
  }

  static double fontSize(double size) {
    const double referenceWidth = 375.0;
    // Add min/max constraints for readability
    return (size * (screenWidth / referenceWidth)).clamp(8.0, 40.0);
  }
  
  /// Helper for spacing with overflow prevention
  static double spacing(double size) {
    return width(size) * 0.95; // 5% safety margin
  }
}
