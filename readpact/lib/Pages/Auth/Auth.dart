import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'Login.dart';
import 'Register.dart';
import '../../Service/theme_service.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  void toggleAuth() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  Widget buildAppTitle(AppColors colors, bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Read",
          style: GoogleFonts.playfairDisplay(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        SizedBox(width: 4),
        Text(
          "Pact",
          style: GoogleFonts.playfairDisplay(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: colors.primary,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(
      builder: (context, themeService, child) {
        final colors = themeService.colors;
        final isDarkMode = themeService.isDarkMode;

        return Scaffold(
          backgroundColor: colors.background,
          floatingActionButton: FloatingActionButton(
            mini: true,
            backgroundColor: colors.primary,
            onPressed: themeService.toggleTheme,
            child: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: Colors.white,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  SizedBox(height: 120),
                  buildAppTitle(colors, isDarkMode),
                  SizedBox(height: 120),
                  isLogin
                      ? LoginWidget(onToggle: toggleAuth, colors: colors)
                      : RegisterWidget(onToggle: toggleAuth, colors: colors),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
