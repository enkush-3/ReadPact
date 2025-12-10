import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../Service/theme_service.dart';
import '../../../Widgets/app_header.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  // Sample book data
  final List<Map<String, String>> bestSellers = [
    {
      'image': 'assets/icons/home.svg',
      'title': 'Шидэт мухлаг',
      'author': 'Жеймс Р. Доти',
    },
    {
      'image': 'assets/book2.jpg',
      'title': 'Шөнийн гүн, таг дуугүй',
      'author': 'Э. Цогзолмаа',
    },
    {
      'image': 'assets/book3.jpg',
      'title': 'Эрэлхэг шинэ чи',
      'author': 'Корн Ален',
    },
  ];

  final List<Map<String, String>> newBooks = [
    {
      'image': 'assets/book1.jpg',
      'title': 'Шидэт мухлаг',
      'author': 'Жеймс Р. Доти',
      'description':
          'Сэтгэл түгшүүр амьдралаас өөр эзэнгүй эзлэхэд хотын байдлын хүү Жим. Тэрээр архины хамааралтай эцэг, өвчтэй ээж, эсэргүүцэх насан түүшдээ асрах хүүв гайхамшигт учрал түүний амьдралын зам өөрчит өөрчлөгдсөн юм.',
    },
    {
      'image': 'assets/book2.jpg',
      'title': 'Шөнийн гүн, таг дуугүй',
      'author': 'Э. Цогзолмаа',
      'description': 'Ярьж найрсдын түүвэр',
    },
    {
      'image': 'assets/book3.jpg',
      'title': 'Эрэлхэг шинэ чи',
      'author': 'Корн Ален',
      'description': '',
    },
  ];

  final List<String> categories = [
    'Бүгд',
    'Уянгын, романс',
    'ШУ-ы уран зөгнөл',
  ];

  int selectedCategory = 0;

  Widget buildCategoryChips(AppColors colors) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final isSelected = selectedCategory == index;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(
                categories[index],
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: isSelected
                      ? colors.text
                      : colors.text.withValues(alpha: 0.6),
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  selectedCategory = index;
                });
              },
              backgroundColor: colors.cardBackground,
              selectedColor: colors.secondary,
              side: BorderSide(
                color: isSelected ? colors.text : colors.border,
                width: 1.5,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildBestSellers(AppColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Best Sellers',
            style: GoogleFonts.playfairDisplay(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: colors.text,
            ),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: bestSellers.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Container(
                  width: 130,
                  decoration: BoxDecoration(
                    color: colors.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.book,
                      size: 60,
                      color: colors.text.withValues(alpha: 0.3),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildNewBooks(AppColors colors, {Color? background}) {
    return Container(
      color: background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Шинээр нэмэгдсэн',
              style: GoogleFonts.playfairDisplay(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: colors.text,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: newBooks.length,
            itemBuilder: (context, index) {
              final book = newBooks[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 140,
                      decoration: BoxDecoration(
                        color: colors.secondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.book,
                          size: 40,
                          color: colors.text.withValues(alpha: 0.3),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            book['title']!,
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: colors.text,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            book['author']!,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: colors.primary,
                            ),
                          ),
                          if (book['description']!.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Text(
                              book['description']!,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: colors.text.withValues(alpha: 0.7),
                                height: 1.4,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(
      builder: (context, themeService, child) {
        final colors = themeService.colors;

        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppHeader(
                  showTitle: true,
                ), // Uses the shared header with Title
                buildCategoryChips(colors),
                const SizedBox(height: 4),
                Container(height: 2, color: colors.text),
                const SizedBox(height: 16),
                buildBestSellers(colors),
                const SizedBox(height: 16),
                buildNewBooks(colors),
                const SizedBox(height: 80),
              ],
            ),
          ),
        );
      },
    );
  }
}
