import 'package:flutter/material.dart';
import '../models/profile.dart';

class ProfileProvider with ChangeNotifier {
  Profile _profile = Profile(
    name: "Lutfi Cahya Nugraha",
    position: "Software Engineer",
    location: "Tangerang Selatan, Indonesia",
  );

  Profile get profile => _profile;

  void updateProfile(Profile newProfile) {
    _profile = newProfile;
    notifyListeners();
  }
}
