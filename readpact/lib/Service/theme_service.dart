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

  // Build a ThemeData that matches these colors
  ThemeData toThemeData(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return ThemeData(
      brightness: brightness,
      primaryColor: primary,
      scaffoldBackgroundColor: background,
      cardColor: cardBackground,
      canvasColor: background,
      dividerColor: border,
      appBarTheme: AppBarTheme(
        backgroundColor: primary,
        foregroundColor: cardBackground.computeLuminance() > 0.5 ? Colors.black : Colors.white,
        elevation: 0,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: brightness,
        primary: primary,
        background: background,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: text),
        bodyMedium: TextStyle(color: text),
        bodySmall: TextStyle(color: text),
      ),
      iconTheme: IconThemeData(color: text),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: secondary,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: border),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      // keep visual density and other defaults
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}

class ThemeService extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  AppColors get colors => _isDarkMode ? AppColors.dark : AppColors.light;

  // New: provide ThemeData for MaterialApp / Theme usage
  ThemeData get themeData => colors.toThemeData(_isDarkMode ? Brightness.dark : Brightness.light);

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setTheme(bool isDark) {
    _isDarkMode = isDark;
    notifyListeners();
  }
}
