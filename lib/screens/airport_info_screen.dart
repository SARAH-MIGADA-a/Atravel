import 'package:flutter/material.dart';

class AirportInfoScreen extends StatelessWidget {
  final String? selectedAirport; // Change this type based on what you need (String, String?, etc.)

  AirportInfoScreen({this.selectedAirport});

  @override
  Widget build(BuildContext context) {
    // Placeholder data for weather and airport status
    final String weather = "Clear skies, 25°C"; // Example weather update
    final String airportStatus = "Open with normal operations"; // Example airport status

    return Scaffold(
      appBar: AppBar(
        title: Text('Airport Information'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selected Airport: $selectedAirport',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Weather Information
            Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.wb_sunny, size: 30, color: Colors.orange),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Weather: $weather',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Airport Status Information
            Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.airport_shuttle, size: 30, color: Colors.blue),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Status: $airportStatus',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Back Button
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the previous screen
              },
              child: Text('Back to Booking'),
            ),
          ],
        ),
      ),
    );
  }
}
