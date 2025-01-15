import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class SharedPreferencesService {
  // Keys for SharedPreferences
  static const String _keyUserName = 'userName';
  static const String _keyUserEmail = 'userEmail';
  static const String _keyUserProfileImagePath = 'userProfileImagePath';

  // Save user profile data to SharedPreferences
  Future<void> saveUserProfile({
    required String userName,
    required String userEmail,
    File? userProfileImage,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserName, userName);
    await prefs.setString(_keyUserEmail, userEmail);
    if (userProfileImage != null) {
      await prefs.setString(_keyUserProfileImagePath, userProfileImage.path);
    } else {
      await prefs.remove(_keyUserProfileImagePath);
    }
    print('User profile saved to SharedPreferences'); // Debug log
  }

  // Load user profile data from SharedPreferences
  Future<Map<String, dynamic>> loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userName = prefs.getString(_keyUserName) ?? 'John Doe';
    final userEmail = prefs.getString(_keyUserEmail) ?? 'johndoe@example.com';
    final userProfileImagePath = prefs.getString(_keyUserProfileImagePath);

    File? userProfileImage;
    if (userProfileImagePath != null) {
      userProfileImage = File(userProfileImagePath);
    }

    print('User profile loaded from SharedPreferences'); // Debug log
    return {
      'userName': userName,
      'userEmail': userEmail,
      'userProfileImage': userProfileImage,
    };
  }

  // Clear user profile data from SharedPreferences
  Future<void> clearUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUserName);
    await prefs.remove(_keyUserEmail);
    await prefs.remove(_keyUserProfileImagePath);
    print('User profile cleared from SharedPreferences'); // Debug log
  }
}