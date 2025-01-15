import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../utils/colors.dart';
import '../utils/shared_preferences_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final SharedPreferencesService _prefsService = SharedPreferencesService();
  String _userName = 'John Doe';
  String _userEmail = 'johndoe@example.com';
  File? _userProfileImage;

  @override
  void initState() {
    super.initState();
    _loadProfileData(); // Load profile data when the page is initialized
  }

  // Method to load profile data from SharedPreferences
  Future<void> _loadProfileData() async {
    final profileData = await _prefsService.loadUserProfile();
    setState(() {
      _userName = profileData['userName'];
      _userEmail = profileData['userEmail'];
      _userProfileImage = profileData['userProfileImage'];
    });
    print('Profile data loaded from SharedPreferences'); // Debug log
  }

  // Method to save profile data to SharedPreferences
  Future<void> _saveProfileData() async {
    await _prefsService.saveUserProfile(
      userName: _userName,
      userEmail: _userEmail,
      userProfileImage: _userProfileImage,
    );
    print('Profile data saved to SharedPreferences'); // Debug log
  }
  Future<void> _clearUserData(BuildContext context) async {
    await _prefsService.clearUserProfile(); // Clear data from SharedPreferences
    setState(() {
      _userName = 'John Doe'; // Reset to default name
      _userEmail = 'johndoe@example.com'; // Reset to default email
      _userProfileImage = null; // Clear profile image
    });

    // Show a SnackBar to notify the user
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('You have been logged out.'),
        duration: Duration(seconds: 2),
      ),
    );

    // Reload the profile data (optional, since we already reset the state)
    await _loadProfileData();
  }

  // Method to pick an image from the gallery
  Future<void> _pickImage() async {
    try {
      print('Opening gallery...'); // Debug log
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        print('Image picked: ${pickedFile.path}'); // Debug log
        setState(() {
          _userProfileImage = File(pickedFile.path);
        });
        await _saveProfileData(); // Save the updated profile image
      } else {
        print('No image selected.'); // Debug log
      }
    } catch (e) {
      print('Error picking image: $e'); // Debug log
    }
  }

  // Method to show the edit profile dialog
  void _editProfile() {
    final nameController = TextEditingController(text: _userName);
    final emailController = TextEditingController(text: _userEmail);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Profile Image Picker
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _userProfileImage != null
                        ? FileImage(_userProfileImage!)
                        : const AssetImage('images/Max.jpg') as ImageProvider,
                  ),
                ),
                const SizedBox(height: 20),
                // Name Field
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                const SizedBox(height: 10),
                // Email Field
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
              ],
            ),
          ),
          actions: [
            // Cancel Button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            // Save Button
            TextButton(
              onPressed: () async {
                setState(() {
                  _userName = nameController.text;
                  _userEmail = emailController.text;
                });
                await _saveProfileData(); // Save the updated name and email
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // Profile Image
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _userProfileImage != null
                      ? FileImage(_userProfileImage!)
                      : const AssetImage('images/Max.jpg') as ImageProvider,
                ),
              ),
              const SizedBox(height: 20),
              // User Name
              Text(
                _userName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // User Email
              Text(
                _userEmail,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              // Edit Profile Option
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit Profile',
                    style: TextStyle(color: AppColors.text)),
                onTap: _editProfile,
              ),
              // Settings Option
              ListTile(
                leading: const Icon(Icons.settings),
                title:
                    const Text('Settings', style: TextStyle(color: AppColors.text)),
                onTap: () {
                  // Navigate to Settings Page
                },
              ),
              // Log Out Option
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.redAccent),
                title: const Text('Log Out', style: TextStyle(color: AppColors.text)),
                onTap: () => _clearUserData(context)
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
