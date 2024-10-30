import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildNotificationItem(
              context,
              title: 'Flight Booking Confirmation',
              message: 'Your flight from Nairobi to Mombasa has been booked successfully.',
              time: '2 hours ago',
              isRead: false),
          _buildNotificationItem(
              context,
              title: 'New Promotions Available',
              message: 'Check out our latest travel promotions and discounts!',
              time: '5 hours ago',
              isRead: true),
          _buildNotificationItem(
              context,
              title: 'Payment Received',
              message: 'We have received your payment for the flight.',
              time: '1 day ago',
              isRead: true),
          _buildNotificationItem(
              context,
              title: 'Profile Update Successful',
              message: 'Your profile has been updated successfully.',
              time: '2 days ago',
              isRead: true),
          _buildNotificationItem(
              context,
              title: 'New Feature Alert',
              message: 'We have added new features to enhance your experience!',
              time: '3 days ago',
              isRead: false),
          _buildNotificationItem(
              context,
              title: 'Feedback Request',
              message: 'We value your feedback! Please take a moment to share your thoughts.',
              time: '1 week ago',
              isRead: true),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(
      BuildContext context, {
        required String title,
        required String message,
        required String time,
        required bool isRead,
      }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isRead ? Colors.black : Colors.deepPurple,
          ),
        ),
        subtitle: Text(
          message,
          style: TextStyle(color: Colors.grey[700]),
        ),
        trailing: Text(
          time,
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        onTap: () {
          // Handle notification tap
          _showNotificationDetails(context, title, message);
        },
      ),
    );
  }

  void _showNotificationDetails(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
