import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Service/theme_service.dart';
import '../../../Widgets/app_header.dart'; // Import AppHeader

class BookSearchScreen extends StatefulWidget {
  const BookSearchScreen({super.key});

  @override
  State<BookSearchScreen> createState() => _BookSearchScreenState();
}

class _BookSearchScreenState extends State<BookSearchScreen> {
  // Хайлтын үр дүнгийн жишээ өгөгдөл
  final List<Map<String, String>> searchResults = [
    {
      "title": "Шидэт мухлаг",
      "author": "Жеймс Р. Доти",
      "description":
          "Салхинд туугдах хамхуулаас өөр эзэнгүй зэлүүд хотын бяцхан хүү Жим. Тэрээр архины хамааралтай аав, бие муутай ээжийгээ насан туршдаа асрах...",
      "image":
          "https://m.media-amazon.com/images/I/81DiH10iFRL._AC_UF1000,1000_QL80_.jpg",
    },
    {
      "title": "Шөнийн гүн, таг дуугүй",
      "author": "Э. Цогзолмаа",
      "description": "Яруу найргийн түүвэр",
      "image":
          "https://m.media-amazon.com/images/I/71KIL16-QeL._AC_UF1000,1000_QL80_.jpg",
    },
    {
      "title": "Эрэлхэг шинэ чи",
      "author": "Кори Ален",
      "description":
          "Харах өнцгөө өөрчилнө гэдэг хүчтэй хүний үйлдэл. Гацсан юм уу тэнэгэрлэсэн үедээ түрхэн зогсоод, эерэг талыг нь олж харахыг хичээ...",
      "image":
          "https://images-na.ssl-images-amazon.com/images/I/71Y-F0-R0JL.jpg",
    },
    {
      "title": "Эрэлхэг шинэ чи",
      "author": "Кори Ален",
      "description":
          "Харах өнцгөө өөрчилнө гэдэг хүчтэй хүний үйлдэл. Гацсан юм уу тэнэгэрлэсэн үедээ түрхэн зогсоод, эерэг талыг нь олж харахыг хичээ...",
      "image":
          "https://images-na.ssl-images-amazon.com/images/I/71Y-F0-R0JL.jpg",
    },
    {
      "title": "Эрэлхэг шинэ чи",
      "author": "Кори Ален",
      "description": "Харах өнцгөө өөрчилнө гэдэг хүчтэй хүний үйлдэл...",
      "image":
          "https://images-na.ssl-images-amazon.com/images/I/71Y-F0-R0JL.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(
      builder: (context, themeService, child) {
        final colors = themeService.colors;

        return SafeArea(
          child: Column(
            children: [
              // 0. App Header
              const AppHeader(),

              // 1. HEADER: Search Bar Area
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Row(
                  children: [
                    // Text Input
                    Expanded(
                      child: SizedBox(
                        height: 45, // Өндрийг тогтмол болгох
                        child: TextField(
                          style: TextStyle(color: colors.text),
                          decoration: InputDecoration(
                            hintText: "Хайх номын нэрээ оруулна уу",
                            hintStyle: TextStyle(
                              color: colors.primary.withOpacity(
                                0.6,
                              ), // Бүдэг цэнхэр hint
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 0,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: colors.primary,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: colors.primary,
                                width: 1.5,
                              ),
                            ),
                            filled: true,
                            fillColor: colors.cardBackground,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Search Button
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: colors.primary, // Товчлуурын цэнхэр өнгө
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.search, color: Colors.white),
                        onPressed: () {
                          // Хайлт хийх үйлдэл
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // 2. Result Count (Илэрц)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Илэрц : ${searchResults.length}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: colors.text.withOpacity(0.6),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // 3. BOOK LIST (Жагсаалт)
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    final book = searchResults[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.all(12),
                      height: 160,
                      decoration: BoxDecoration(
                        color: colors.cardBackground,
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
                          // Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              book['image']!,
                              width: 90,
                              height: 140,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    color: Colors.grey[300],
                                    width: 90,
                                    height: 140,
                                  ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          // Text info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  book['title']!,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: colors.text,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  book['author']!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: colors.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Expanded(
                                  child: Text(
                                    book['description']!,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: colors.text.withOpacity(0.7),
                                      height: 1.3,
                                    ),
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
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
