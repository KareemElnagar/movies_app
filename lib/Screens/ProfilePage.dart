import 'package:flutter/material.dart';

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
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('images/Max.jpg'), // Replace with network image if needed
              ),
              SizedBox(height: 20),
              Text(
                'John Doe',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'johndoe@example.com',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 30),
              Divider(),
              ListTile(
                leading: Icon(Icons.edit,),
                title: Text('Edit Profile',style: TextStyle(color: AppColors.text,) ),
                onTap: () {
                  // Navigate to Edit Profile Page
                },
              ),
              ListTile(
                leading: Icon(Icons.settings, ),
                title: Text('Settings',style: TextStyle(color: AppColors.text,)),
                onTap: () {
                  // Navigate to Settings Page
                },
              ),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.redAccent),
                title: Text('Log Out',style: TextStyle(color: AppColors.text,)),
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
}

