
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5), // Саарал дэвсгэр
      ),
      home: const BookCategoryScreen(),
    );
  }
}

class BookCategoryScreen extends StatefulWidget {
  const BookCategoryScreen({super.key});

  @override
  State<BookCategoryScreen> createState() => _BookCategoryScreenState();
}

class _BookCategoryScreenState extends State<BookCategoryScreen> {
  int _selectedIndex = 1; // Доод цэсний идэвхтэй индекс (Ангилал)
  int _selectedFilterIndex = 1; // Шүүлтүүрийн идэвхтэй индекс (Уран зөгнөлт)

  // Шүүлтүүрийн өгөгдөл
  final List<String> filters = [
    "Бүгд",
    "Уран зөгнөлт",
    "Уянгын, романс",
    "ШУ-ы уран зохиол"
  ];

  // Номын өгөгдөл (Mock Data)
  final List<Map<String, String>> books = [
    {
      "title": "Шидэт мухлаг",
      "author": "Жеймс Р. Доти",
      "description":
          "Салхинд туугдах хамхуулаас өөр эзэнгүй зэлүүд хотын бяцхан хүү Жим. Тэрээр архины хамааралтай аав, бие муутай ээжийгээ насан туршдаа асрах хувь тавиланд төржээ.",
      "image": "https://m.media-amazon.com/images/I/81DiH10iFRL._AC_UF1000,1000_QL80_.jpg" // Placeholder image
    },
    {
      "title": "Шөнийн гүн, таг дуугүй",
      "author": "Э. Цогзолмаа",
      "description": "Яруу найргийн түүвэр",
      "image": "https://m.media-amazon.com/images/I/71KIL16-QeL._AC_UF1000,1000_QL80_.jpg" // Placeholder image
    },
    {
      "title": "Эрэлхэг шинэ чи",
      "author": "Кори Ален",
      "description":
          "Харах өнцгөө өөрчилнө гэдэг хүчтэй хүний үйлдэл. Гацсан юм уу тэнэгэрлэсэн үедээ түрхэн зогсоод, эерэг талыг нь олж харахыг хичээ.",
      "image": "https://images-na.ssl-images-amazon.com/images/I/71Y-F0-R0JL.jpg" // Placeholder image
    },
    {
      "title": "Эрэлхэг шинэ чи",
      "author": "Кори Ален",
      "description":
      "Харах өнцгөө өөрчилнө гэдэг хүчтэй хүний үйлдэл. Гацсан юм уу тэнэгэрлэсэн үедээ түрхэн зогсоод, эерэг талыг нь олж харахыг хичээ.",
      "image": "https://images-na.ssl-images-amazon.com/images/I/71Y-F0-R0JL.jpg" // Placeholder image
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. HEADER & TITLE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
              child: Text(
                "Ангилал",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Serif', // Serif фонт загвартай төстэй
                  color: Colors.black87,
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
                        color: isSelected ? Colors.white : Colors.black54,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      backgroundColor: isSelected ? const Color(0xFF6C8AFF) : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: isSelected ? Colors.transparent : Colors.grey.shade300,
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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.all(12),
                    height: 160,
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                              return Container(color: Colors.grey, width: 90, height: 140);
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
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                book['author']!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF5374FF), // Цэнхэр өнгө
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                book['description']!,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                  height: 1.3,
                                ),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      
      // 4. BOTTOM NAVIGATION BAR
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF5374FF),
        unselectedItemColor: Colors.black54,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: "Category"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: "Bag"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }
}