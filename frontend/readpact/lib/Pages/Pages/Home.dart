import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Widgets/navbar.dart';
import '../../Service/theme_service.dart';
import '../Pages/Navbars/Category.dart';
import '../Pages/SecondPages/Search.dart';
import '../Pages/Navbars/MyBook.dart';
import '../Pages/Navbars/Profile.dart';
import '../Pages/Navbars/Home.dart'; // Import the new HomeTab

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeTab(),
    BookCategoryScreen(),
    BookSearchScreen(),
    MyBooksPage(),
    ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(
      builder: (context, themeService, child) {
        final colors = themeService.colors;

        return Scaffold(
          backgroundColor: colors.background,
          body: IndexedStack(index: _currentIndex, children: _pages),
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: _currentIndex,
            onTap: _onTabTapped,
            colors: colors,
          ),
        );
      },
    );
  }
}
