import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readpact/Pages/Home.dart';
import 'package:readpact/Service/theme_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return ChangeNotifierProvider(
      create: (_) => ThemeService(),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()),
=======
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterPage(),
>>>>>>> origin/enkush
    );
  }
}
