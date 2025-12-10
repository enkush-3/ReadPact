import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/book_model.dart';

class ApiService {
  // TODO: Replace with actual backend URL. Use 10.0.2.2 for Android Emulator localhost.
  static const String baseUrl = 'http://10.0.2.2:8000';

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/users/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {'error': 'Login failed: ${response.body}'};
      }
    } catch (e) {
      return {'error': 'Connection error: $e'};
    }
  }

  Future<Map<String, dynamic>> register(
    String username,
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/users/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return {'success': true};
      } else {
        return {'error': 'Registration failed: ${response.body}'};
      }
    } catch (e) {
      return {'error': 'Connection error: $e'};
    }
  }

  Future<Map<String, dynamic>> verifyEmail(String email, String code) async {
    // Mock verification for now as backend doesn't support it yet
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    return {'token': 'mock-token', 'username': email.split('@')[0]};
  }

  Future<List<Book>> fetchBooks() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/books'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Book.fromJson(json)).toList();
      } else {
        print('Failed to load books: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Fetch books error: $e');
      return [];
    }
  }

  Future<Book?> fetchBookDetails(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/books/$id'));

      if (response.statusCode == 200) {
        return Book.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      print('Fetch book details error: $e');
      return null;
    }
  }
}
