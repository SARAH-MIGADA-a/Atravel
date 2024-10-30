import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final Function onToggleTheme; // Add a callback for toggling the theme

  SettingsScreen({required this.onToggleTheme}); // Constructor to accept the toggle function

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false; // Default theme state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle('Account Settings'),
          _buildSettingItem('Profile', Icons.person, () {
            // Handle Profile navigation
          }),
          _buildSettingItem('Change Password', Icons.lock, () {
            // Handle Change Password navigation
          }),
          Divider(),

          _buildSectionTitle('App Settings'),
          _buildSettingItem('Notifications', Icons.notifications, () {
            // Handle Notifications settings
          }),
          _buildSettingItem('Privacy', Icons.privacy_tip, () {
            // Handle Privacy settings
          }),
          _buildSettingItem('Language', Icons.language, () {
            // Handle Language settings
          }),
          Divider(),

          _buildSectionTitle('Theme'),
          ListTile(
            title: Text('Enable Dark Mode'),
            trailing: Switch(
              value: _isDarkMode,
              onChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                  widget.onToggleTheme(); // Call the theme toggle function
                });
              },
            ),
          ),
          Divider(),

          _buildSectionTitle('Help & Support'),
          _buildSettingItem('FAQ', Icons.help, () {
            // Handle FAQ navigation
          }),
          _buildSettingItem('Contact Us', Icons.contact_support, () {
            // Handle Contact Us navigation
          }),
          Divider(),

          _buildSectionTitle('About App'),
          _buildSettingItem('Terms & Conditions', Icons.article, () {
            // Handle Terms & Conditions navigation
          }),
          _buildSettingItem('Privacy Policy', Icons.security, () {
            // Handle Privacy Policy navigation
          }),
          _buildSettingItem('Version', Icons.info, () {
            // Show app version
            _showVersionDialog(context);
          }),
          Divider(),

          _buildSectionTitle('Log Out'),
          _buildSettingItem('Log Out', Icons.logout, () {
            // Handle Log Out action
            _showLogoutDialog(context);
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

  Widget _buildSettingItem(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(title, style: TextStyle(fontSize: 16)),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
    );
  }

  void _showVersionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('App Version'),
          content: Text('Version 1.0.0'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Log Out'),
          content: Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Handle log out functionality here
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Log Out'),
            ),
          ],
        );
      },
    );
  }
}
