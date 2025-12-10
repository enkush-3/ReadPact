import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Service/theme_service.dart';
import '../../../Widgets/app_header.dart'; // Import AppHeader

class BookCategoryScreen extends StatefulWidget {
  const BookCategoryScreen({super.key});

  @override
  State<BookCategoryScreen> createState() => _BookCategoryScreenState();
}

class _BookCategoryScreenState extends State<BookCategoryScreen> {
  int _selectedFilterIndex = 1; // Шүүлтүүрийн идэвхтэй индекс (Уран зөгнөлт)

  // Шүүлтүүрийн өгөгдөл
  final List<String> filters = [
    "Бүгд",
    "Уран зөгнөлт",
    "Уянгын, романс",
    "ШУ-ы уран зохиол",
  ];

  // Номын өгөгдөл (Mock Data)
  final List<Map<String, String>> books = [
    {
      "title": "Шидэт мухлаг",
      "author": "Жеймс Р. Доти",
      "description":
          "Салхинд туугдах хамхуулаас өөр эзэнгүй зэлүүд хотын бяцхан хүү Жим. Тэрээр архины хамааралтай аав, бие муутай ээжийгээ насан туршдаа асрах хувь тавиланд төржээ.",
      "image":
          "https://m.media-amazon.com/images/I/81DiH10iFRL._AC_UF1000,1000_QL80_.jpg", // Placeholder image
    },
    {
      "title": "Шөнийн гүн, таг дуугүй",
      "author": "Э. Цогзолмаа",
      "description": "Яруу найргийн түүвэр",
      "image":
          "https://m.media-amazon.com/images/I/71KIL16-QeL._AC_UF1000,1000_QL80_.jpg", // Placeholder image
    },
    {
      "title": "Эрэлхэг шинэ чи",
      "author": "Кори Ален",
      "description":
          "Харах өнцгөө өөрчилнө гэдэг хүчтэй хүний үйлдэл. Гацсан юм уу тэнэгэрлэсэн үедээ түрхэн зогсоод, эерэг талыг нь олж харахыг хичээ.",
      "image":
          "https://images-na.ssl-images-amazon.com/images/I/71Y-F0-R0JL.jpg", // Placeholder image
    },
    {
      "title": "Эрэлхэг шинэ чи",
      "author": "Кори Ален",
      "description":
          "Харах өнцгөө өөрчилнө гэдэг хүчтэй хүний үйлдэл. Гацсан юм уу тэнэгэрлэсэн үедээ түрхэн зогсоод, эерэг талыг нь олж харахыг хичээ.",
      "image":
          "https://images-na.ssl-images-amazon.com/images/I/71Y-F0-R0JL.jpg", // Placeholder image
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(
      builder: (context, themeService, child) {
        final colors = themeService.colors;
        // final isDarkMode = themeService.isDarkMode; // Not used directly, but widget consumes 'colors'

        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 0. App Header with Theme Toggle
              const AppHeader(),

              // 1. HEADER & TITLE (Existing)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 5, // Reduced vertical padding
                ),
                child: Text(
                  "Ангилал",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Playfair Display',
                    color: colors.text,
                  ),
                ),
              ),

              // 2. HORIZONTAL FILTERS
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: filters.length,
                  itemBuilder: (context, index) {
                    final isSelected = index == _selectedFilterIndex;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: ActionChip(
                        label: Text(filters[index]),
                        labelStyle: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : colors.text.withOpacity(0.7),
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        backgroundColor: isSelected
                            ? colors.primary
                            : colors.cardBackground,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: isSelected
                                ? Colors.transparent
                                : colors.border,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedFilterIndex = index;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 10),

              // 3. BOOK LIST
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.all(12),
                      height: 160,
                      decoration: BoxDecoration(
                        color: colors.cardBackground, // Updated
                        borderRadius: BorderRadius.circular(15),
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
                          // Зураг
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              book['image']!,
                              width: 90,
                              height: 140,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey,
                                  width: 90,
                                  height: 140,
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 15),
                          // Текст мэдээлэл
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  book['title']!,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: colors.text, // Updated
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  book['author']!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: colors.primary, // Updated
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  book['description']!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: colors.text.withOpacity(
                                      0.7,
                                    ), // Updated
                                    height: 1.3,
                                  ),
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
