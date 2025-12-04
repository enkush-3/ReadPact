import 'package:flutter/material.dart';
import '../Widgets/navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  static const List<Widget> _pages = [
    Center(child: Text('Home')),
    Center(child: Text('Categories')),
    Center(child: Text('Search')),
    Center(child: Text('Bookmarks')),
    Center(child: Text('Profile')),
  ];

  void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_currentIndex]),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
        // optional: provide background color if desired
        // background: Colors.white,
      ),
    );
  }
}
