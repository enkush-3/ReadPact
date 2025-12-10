import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    background: const Color(0xFFF8F9FE), // Cleaner off-white
    primary: const Color(0xFF4361EE), // Vibrant Premium Blue
    text: const Color(0xFF1B1B1F), // Softer Black
    secondary: const Color(
      0xFFEFF3FF,
    ), // Light Blue tint for varied backgrounds
    border: const Color(0xFFE0E0E0),
    cardBackground: const Color(0xFFFFFFFF),
  );

  static AppColors dark = AppColors(
    background: const Color(0xFF101014), // Deep dark
    primary: const Color(0xFF5372FF), // Brighter Blue for dark mode
    text: const Color(0xFFEAEAEA),
    secondary: const Color(0xFF1E1E24),
    border: const Color(0xFF2A2A2A),
    cardBackground: const Color(0xFF18181C),
  );

  // Build a ThemeData that matches these colors
  ThemeData toThemeData(Brightness brightness) {
    // Import Google Fonts manually here to avoid top-level import conflicts if necessary,
    // but usually better to import at top. Assuming import is there.

    final isDark = brightness == Brightness.dark;
    final baseTheme = isDark ? ThemeData.dark() : ThemeData.light();

    return baseTheme.copyWith(
      primaryColor: primary,
      scaffoldBackgroundColor: background,
      cardColor: cardBackground,
      canvasColor: background,
      dividerColor: border,
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: text,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: text),
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: brightness,
        primary: primary,
        surface: cardBackground,
        background: background,
        onBackground: text,
      ),
      textTheme: GoogleFonts.interTextTheme(
        baseTheme.textTheme,
      ).apply(bodyColor: text, displayColor: text),
      iconTheme: IconThemeData(color: text),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: secondary,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primary, width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      // Visual Density
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}

class ThemeService extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  AppColors get colors => _isDarkMode ? AppColors.dark : AppColors.light;

  // New: provide ThemeData for MaterialApp / Theme usage
  ThemeData get themeData =>
      colors.toThemeData(_isDarkMode ? Brightness.dark : Brightness.light);

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setTheme(bool isDark) {
    _isDarkMode = isDark;
    notifyListeners();
  }
}
