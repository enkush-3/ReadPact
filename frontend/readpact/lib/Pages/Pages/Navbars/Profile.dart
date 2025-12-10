import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Service/theme_service.dart';
import '../../../Widgets/app_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(
      builder: (context, themeService, child) {
        final colors = themeService.colors;

        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Header
                  const AppHeader(),

                  // "Profile" гарчиг
                  Text(
                    'Profile',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: colors.text,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Профайл карт
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    decoration: BoxDecoration(
                      color: colors.secondary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        // Аватар зураг
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: colors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Username
                        Text(
                          '@username',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: colors.text,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // ID
                        Text(
                          'ID: 1234567',
                          style: TextStyle(
                            fontSize: 14,
                            color: colors.text.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // "Таны И-мэйл" гарчиг
                  Text(
                    'Таны И-мэйл',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: colors.text,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // И-мэйл харуулах хэсэг
                  Container(
                    decoration: BoxDecoration(
                      color: colors.cardBackground,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: colors.border),
                    ),
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: 'xxx@gmail.com',
                        hintStyle: TextStyle(color: colors.text),
                        prefixIcon: Icon(
                          Icons.mail_outline,
                          color: colors.text.withOpacity(0.6),
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  // Тусгаарлагч зураас
                  Divider(color: colors.border),
                  const SizedBox(height: 20),

                  // "Тохиргоо" товчлуур
                  Container(
                    decoration: BoxDecoration(
                      color: colors.cardBackground,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: colors.border),
                    ),
                    child: ListTile(
                      onTap: () {
                        // Тохиргоо руу үсрэх үйлдэл
                      },
                      title: Text(
                        'Тохиргоо',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: colors.text,
                        ),
                      ),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: colors.text.withOpacity(0.6),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // "Гарах" товчлуур
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        // Гарах үйлдэл
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Гарах',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
