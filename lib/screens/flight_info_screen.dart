
import 'package:flutter/material.dart';

class FlightInfoScreen extends StatelessWidget {
  final String flightType;
  final int numberOfPassengers;

  // Constructor to accept parameters
  FlightInfoScreen({required this.flightType, required this.numberOfPassengers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flight Info'),
      ),
      body: Container(
        color: Colors.lightBlue[50], // Light background color
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Flight Type Card
            Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.flight_takeoff, size: 30),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Flight Type: $flightType',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Number of Passengers Card
            Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.people, size: 30),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Number of Passengers: $numberOfPassengers',
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
