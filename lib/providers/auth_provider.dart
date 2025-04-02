import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';
import '../models/user.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  final AuthService _authService = AuthService();

  User? get user => _user;

  Future<void> signup(String email, String password) async {
    _user = await _authService.signup(email, password);
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    _user = await _authService.login(email, password);
    notifyListeners();
  }

  Future<void> refresh() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refreshToken') ?? '';
    final newAccessToken = await _authService.refreshToken(refreshToken);
    _user = User(email: _user!.email, accessToken: newAccessToken, refreshToken: refreshToken);
    notifyListeners();
  }
}