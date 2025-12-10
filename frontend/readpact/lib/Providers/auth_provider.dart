import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Service/api_service.dart';
import '../Models/user_model.dart';

class AuthProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  User? _user;
  String? _token;
  bool _isLoading = false;

  User? get user => _user;
  bool get isAuthenticated => _token != null;
  bool get isLoading => _isLoading;

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    final username = prefs.getString('username');
    final email = prefs.getString('email');

    if (_token != null && username != null && email != null) {
      _user = User(username: username, email: email);
    }
    notifyListeners();
  }

  Future<String?> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final result = await _apiService.login(email, password);

    if (result.containsKey('token')) {
      _token = result['token'];
      // Assuming backend returns user info or we use email as placeholder
      String username = result['username'] ?? 'User';
      _user = User(username: username, email: email);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _token!);
      await prefs.setString('email', email);
      await prefs.setString('username', username);

      _isLoading = false;
      notifyListeners();
      return null; // Success
    } else {
      _isLoading = false;
      notifyListeners();
      return result['error'] ?? 'Login failed';
    }
  }

  Future<String?> register(
    String username,
    String email,
    String password,
  ) async {
    _isLoading = true;
    notifyListeners();

    final result = await _apiService.register(username, email, password);

    _isLoading = false;
    notifyListeners();

    if (result.containsKey('success')) {
      return null; // Success
    } else {
      return result['error'] ?? 'Registration failed';
    }
  }

  Future<String?> verify(String email, String code) async {
    _isLoading = true;
    notifyListeners();

    final result = await _apiService.verifyEmail(email, code);

    if (result.containsKey('token')) {
      _token = result['token'];
      // Assuming backend returns user info or we use email as placeholder
      String username = result['username'] ?? 'User';
      _user = User(username: username, email: email);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _token!);
      await prefs.setString('email', email);
      await prefs.setString('username', username);

      _isLoading = false;
      notifyListeners();
      return null; // Success
    } else {
      _isLoading = false;
      notifyListeners();
      return result['error'] ?? 'Verification failed';
    }
  }

  Future<void> logout() async {
    _token = null;
    _user = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }
}
