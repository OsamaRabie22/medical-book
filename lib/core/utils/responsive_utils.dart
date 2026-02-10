import 'package:flutter/material.dart';

class ResponsiveUtils {
  static double getScale(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const baseWidth = 430.0; // iPhone 14 Pro Max
    return screenWidth / baseWidth;
  }

  static double responsiveSize(BuildContext context, double size) {
    return size * getScale(context);
  }

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600;
  }
}