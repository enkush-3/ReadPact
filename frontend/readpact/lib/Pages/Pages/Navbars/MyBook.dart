import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../Service/theme_service.dart';
import '../../../Widgets/app_header.dart'; // Import AppHeader

class MyBooksPage extends StatelessWidget {
  const MyBooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(
      builder: (context, themeService, child) {
        final colors = themeService.colors;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 0. App Header
                const AppHeader(),

                // --- 1. Header Title ---
                Text(
                  'My Books',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: colors.text,
                  ),
                ),
                const SizedBox(height: 20),

                // --- 2. Filter Tabs ---
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FilterButton(
                        text: "Татсан ном",
                        isSelected: false,
                        colors: colors,
                      ),
                      const SizedBox(width: 10),
                      FilterButton(
                        text: "Уншиж байгаа ном",
                        isSelected: true,
                        colors: colors,
                      ),
                      const SizedBox(width: 10),
                      FilterButton(
                        text: "Дуртай ном",
                        isSelected: false,
                        colors: colors,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // --- 3. Book List ---
                Expanded(
                  child: ListView(
                    children: [
                      BookCard(
                        title: "Шөнийн гүн, таг дуугүй",
                        author: "Э. Цогзолмаа",
                        progress: 0.3,
                        imageUrl: "https://via.placeholder.com/150",
                        colorPlaceholder: Colors.blueGrey.shade900,
                        colors: colors,
                      ),
                      BookCard(
                        title: "Эрэлхэг шинэ чи",
                        author: "Кори Ален",
                        progress: 0.3,
                        imageUrl: "https://via.placeholder.com/150",
                        isLightCover: true,
                        colors: colors,
                      ),
                      BookCard(
                        title: "Шидэт мухлаг",
                        author: "Жеймс Р. Доти",
                        progress: 0.3,
                        imageUrl: "https://via.placeholder.com/150",
                        colorPlaceholder: Colors.teal.shade800,
                        colors: colors,
                      ),
                      BookCard(
                        title: "Эрэлхэг шинэ чи",
                        author: "Кори Ален",
                        progress: 0.3,
                        imageUrl: "https://via.placeholder.com/150",
                        isLightCover: true,
                        colors: colors,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// --- Custom Widget: Filter Button ---
class FilterButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final AppColors colors;

  const FilterButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? colors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: isSelected ? Colors.transparent : colors.border,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : colors.text.withOpacity(0.7),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// --- Custom Widget: Book Card ---
class BookCard extends StatelessWidget {
  final String title;
  final String author;
  final double progress;
  final String imageUrl;
  final Color? colorPlaceholder;
  final bool isLightCover;
  final AppColors colors;

  const BookCard({
    super.key,
    required this.title,
    required this.author,
    required this.progress,
    required this.imageUrl,
    required this.colors,
    this.colorPlaceholder,
    this.isLightCover = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Book Cover Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 100,
              height: 140,
              color: colorPlaceholder ?? Colors.grey.shade200,
              child: isLightCover
                  ? const Center(
                      child: Text(
                        "Book Cover",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : null,
            ),
          ),
          const SizedBox(width: 16),

          // Book Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colors.text,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  author,
                  style: TextStyle(
                    color: colors.primary,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),

                // Progress Bar
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: colors.border,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            colors.primary,
                          ),
                          minHeight: 6,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      "${(progress * 100).toInt()}%",
                      style: TextStyle(
                        fontSize: 12,
                        color: colors.text.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Button
                SizedBox(
                  width: double.infinity,
                  height: 36,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: colors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      "Үргэлжлүүлэн унших",
                      style: TextStyle(color: colors.primary, fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
