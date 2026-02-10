import 'package:flutter/material.dart';

class AppColors {
  // الألوان الأساسية
  static const Color primary = Color(0xFF128C7E);
  static const Color primaryDark = Color(0xFF075E54);
  static const Color primaryLight = Color(0xFF25D366);
  static const Color accent = Color(0xFF34B7F1);

  // الألوان المحايدة
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color greyLight = Color(0xFFE0E0E0);
  static const Color greyDark = Color(0xFF616161);

  // ألوان الحالة
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // خلفيات
  static const Color scaffoldBackground = Color(0xFFEFF9F8);
  static const Color cardBackground = Color(0xFFFFFFFF);
}

class AppGradients {
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF128C7E), Color(0xFF25D366)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}