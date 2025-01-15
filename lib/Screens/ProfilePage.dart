import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../cubit/show_cubit.dart'; // Import your ShowCubit
import '../utils/colors.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              // Profile Image
              BlocBuilder<ShowCubit, ShowState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () => _pickImage(context),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: state.userProfileImage != null
                          ? FileImage(state.userProfileImage!)
                          : AssetImage('images/Max.jpg') as ImageProvider,
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              // User Name
              BlocBuilder<ShowCubit, ShowState>(
                builder: (context, state) {
                  return Text(
                    state.userName,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
              // User Email
              BlocBuilder<ShowCubit, ShowState>(
                builder: (context, state) {
                  return Text(
                    state.userEmail,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
              SizedBox(height: 30),
              Divider(),
              // Edit Profile Option
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit Profile', style: TextStyle(color: AppColors.text)),
                onTap: () => _editProfile(context),
              ),
              // Settings Option
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings', style: TextStyle(color: AppColors.text)),
                onTap: () {
                  // Navigate to Settings Page
                },
              ),
              // Log Out Option
              ListTile(
                leading: Icon(Icons.logout, color: Colors.redAccent),
                title: Text('Log Out', style: TextStyle(color: AppColors.text)),
                onTap: () {
                  // Handle Log Out
                },
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }

  // Method to pick an image from the gallery
  Future<void> _pickImage(BuildContext context) async {
    try {
      print('Opening gallery...'); // Debug log
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        print('Image picked: ${pickedFile.path}'); // Debug log
        final imageFile = File(pickedFile.path);
        context.read<ShowCubit>().updateUserProfileImage(imageFile);
      } else {
        print('No image selected.'); // Debug log
      }
    } catch (e) {
      print('Error picking image: $e'); // Debug log
    }
  }

  // Method to show the edit profile dialog
  void _editProfile(BuildContext context) {
    final showCubit = context.read<ShowCubit>();
    final currentState = showCubit.state;

    final nameController = TextEditingController(text: currentState.userName);
    final emailController = TextEditingController(text: currentState.userEmail);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Profile Image Picker
                GestureDetector(
                  onTap: () => _pickImage(context),
                  child: BlocBuilder<ShowCubit, ShowState>(
                    builder: (context, state) {
                      return CircleAvatar(
                        radius: 50,
                        backgroundImage: state.userProfileImage != null
                            ? FileImage(state.userProfileImage!)
                            : AssetImage('images/Max.jpg') as ImageProvider,
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                // Name Field
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                SizedBox(height: 10),
                // Email Field
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
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
              child: Text('Cancel'),
            ),
            // Save Button
            TextButton(
              onPressed: () {
                // Update name and email in the state
                showCubit.updateUserName(nameController.text);
                showCubit.updateUserEmail(emailController.text);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}