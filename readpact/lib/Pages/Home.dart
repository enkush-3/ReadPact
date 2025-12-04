import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Widgets/navbar.dart';
import '../Service/theme_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // Sample book data
  final List<Map<String, String>> bestSellers = [
    {
      'image': 'assets/book1.jpg',
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

  Widget buildHeader(AppColors colors, bool isDarkMode, VoidCallback onToggle) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'Read',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              Text(
                'Pact',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: colors.primary,
                ),
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: colors.text,
            ),
            onPressed: onToggle,
          ),
        ],
      ),
    );
  }

  Widget buildCategoryChips(AppColors colors) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 16),
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
            padding: EdgeInsets.symmetric(horizontal: 16),
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

  Widget buildNewBooks(AppColors colors) {
    return Column(
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
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16),
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
                  SizedBox(width: 16),
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
                        SizedBox(height: 4),
                        Text(
                          book['author']!,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: colors.primary,
                          ),
                        ),
                        if (book['description']!.isNotEmpty) ...[
                          SizedBox(height: 8),
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
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildHeader(colors, isDarkMode, themeService.toggleTheme),
                  buildCategoryChips(colors),
                  SizedBox(height: 4),
                  Container(height: 2, color: colors.text),
                  SizedBox(height: 16),
                  buildBestSellers(colors),
                  SizedBox(height: 16),
                  buildNewBooks(colors),
                  SizedBox(height: 80),
                ],
              ),
            ),
          ),
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            colors: colors,
          ),
        );
      },
    );
  }
}
