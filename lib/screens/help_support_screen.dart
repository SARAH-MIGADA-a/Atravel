import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Support'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle('FAQ'),
          _buildHelpItem('How to reset my password?', () {
            // Handle FAQ navigation
          }),
          _buildHelpItem('How to change my email address?', () {
            // Handle FAQ navigation
          }),
          Divider(),

          _buildSectionTitle('Contact Us'),
          _buildHelpItem('Email Support', () {
            // Handle email support navigation
          }),
          _buildHelpItem('Call Support', () {
            // Handle call support action
          }),
          Divider(),

          _buildSectionTitle('Feedback'),
          _buildHelpItem('Send Feedback', () {
            // Handle feedback submission
          }),
          _buildHelpItem('Rate Us', () {
            // Handle app rating action
          }),
          Divider(),

          _buildSectionTitle('Community'),
          _buildHelpItem('Join our Community', () {
            // Handle community navigation
          }),
          _buildHelpItem('Follow us on Social Media', () {
            // Handle social media navigation
          }),
          Divider(),

          _buildSectionTitle('About'),
          _buildHelpItem('Terms of Service', () {
            // Handle Terms of Service navigation
          }),
          _buildHelpItem('Privacy Policy', () {
            // Handle Privacy Policy navigation
          }),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildHelpItem(String title, VoidCallback onTap) {
    return ListTile(
      title: Text(title, style: TextStyle(fontSize: 16)),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
    );
  }
}
