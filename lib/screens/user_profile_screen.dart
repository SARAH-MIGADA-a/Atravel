import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  final String username;
  final String email;
  final String phoneNumber;
  final String address;
  final String dateOfBirth;
  final String profilePictureUrl;

  UserProfileScreen({
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.dateOfBirth,
    required this.profilePictureUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Picture
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(profilePictureUrl),
              ),
              SizedBox(height: 20),

              // User Information
              _buildUserInfoCard('Username', username),
              _buildUserInfoCard('Email', email),
              _buildUserInfoCard('Phone Number', phoneNumber),
              _buildUserInfoCard('Address', address),
              _buildUserInfoCard('Date of Birth', dateOfBirth),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implement logout functionality here
                },
                child: Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfoCard(String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
