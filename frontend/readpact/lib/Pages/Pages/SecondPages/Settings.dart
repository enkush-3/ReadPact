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
      title: 'Settings UI',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF2F2F2), // Арын фон өнгө
        primarySwatch: Colors.blue,
      ),
      home: const SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // 1. HEADER (Толгой хэсэг)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Буцах товч (Дугуй хүрээтэй)
                  InkWell(
                    onTap: () {
                      // Буцах үйлдэл энд бичигдэнэ
                      print("Back clicked");
                    },
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black54, width: 0.8),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 20,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  // Гарчиг
                  const Text(
                    "Тохиргоо",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Serif', // Serif загвартай фонт
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              const Divider(color: Colors.grey, thickness: 0.5),
              const SizedBox(height: 20),

              // 2. ACCOUNT SETTINGS SECTION
              const Text(
                "Account Settings",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),

              // Жагсаалтын мөрүүд (Custom Widget ашиглав)
              _buildSettingsItem(title: "Профайл засах", onTap: () {}),
              _buildSettingsItem(title: "Нууц үг солих", onTap: () {}),

              const SizedBox(height: 30),
              const Divider(
                color: Colors.grey,
                thickness: 0.5,
              ), // Хэсэг хоорондын зураас
              const SizedBox(height: 30),

              // 3. OTHER (БУСАД) SECTION
              const Text(
                "Бусад",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),

              _buildSettingsItem(title: "Бидний тухай", onTap: () {}),
              _buildSettingsItem(title: "Нууцлал", onTap: () {}),

              const Spacer(), // Доод зайг дүүргэх
            ],
          ),
        ),
      ),
    );
  }

  // Жагсаалтын нэг мөрийг үүсгэдэг функц (Дахин ашиглах зорилгоор)
  Widget _buildSettingsItem({
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        contentPadding: EdgeInsets.zero, // Default зайг арилгах
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          size: 20,
          color: Colors.black54,
        ),
        onTap: onTap,
      ),
    );
  }
}
