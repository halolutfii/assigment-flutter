import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/user_service.dart';

class UserProvider with ChangeNotifier {
  User? _profile;
  final UserService _userService = UserService();

  User? get profile => _profile;

  Future<void> loadUser() async {
    try {
      _profile = await _userService.fetchUser();
      notifyListeners();
    } catch (e) {
      print('Error loading user: $e');
      _profile = null;
      notifyListeners();
    }
  }

  void clearUser() {
    _profile = null;
    notifyListeners();
  }
}