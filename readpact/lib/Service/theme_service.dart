import 'package:flutter/material.dart';

class AppColors {
  final Color background;
  final Color primary;
  final Color text;
  final Color secondary;
  final Color border;
  final Color cardBackground;

  AppColors({
    required this.background,
    required this.primary,
    required this.text,
    required this.secondary,
    required this.border,
    required this.cardBackground,
  });

  static AppColors light = AppColors(
    background: Color(0xFFF5F5F5),
    primary: Color(0xFF6B8CFF),
    text: Color(0xFF545454),
    secondary: Color(0xFFF0F0F0),
    border: Color(0xFFF0F0F0),
    cardBackground: Color(0xFFFFFFFF),
  );

  static AppColors dark = AppColors(
    background: Color(0xFF000000),
    primary: Color(0xFF6B8CFF),
    text: Color(0xFFCDCDCD),
    secondary: Color(0xFF3F3F3F),
    border: Color(0xFF3F3F3F),
    cardBackground: Color(0xFF1A1A1A),
  );
}

class ThemeService extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  AppColors get colors => _isDarkMode ? AppColors.dark : AppColors.light;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setTheme(bool isDark) {
    _isDarkMode = isDark;
    notifyListeners();
  }
}
