import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import 'Ticket.dart';

class SharedPreferencesService {
  // Keys for SharedPreferences
  static const String _keyUserName = 'userName';
  static const String _keyUserEmail = 'userEmail';
  static const String _keyUserProfileImagePath = 'userProfileImagePath';
  static const String _keyTickets = 'bookedTickets';

  // Save tickets to SharedPreferences
  Future<void> saveTickets(List<Ticket> tickets) async {
    final prefs = await SharedPreferences.getInstance();
    final ticketsJson = tickets.map((ticket) => ticket.toJson()).toList();
    await prefs.setString(_keyTickets, jsonEncode(ticketsJson));
    print('Tickets saved to SharedPreferences'); // Debug log
  }

  // Load tickets from SharedPreferences
  Future<List<Ticket>> loadTickets() async {
    final prefs = await SharedPreferences.getInstance();
    final ticketsJson = prefs.getString(_keyTickets);

    if (ticketsJson != null) {
      final List<dynamic> decodedJson = jsonDecode(ticketsJson);
      final tickets = decodedJson.map((json) => Ticket.fromJson(json)).toList();
      print('Tickets loaded from SharedPreferences'); // Debug log
      return tickets;
    } else {
      print('No tickets found in SharedPreferences'); // Debug log
      return [];
    }
  }

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