import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  final String flightType;
  final String? departureCity;
  final String? destinationCity;
  final String? preferredAirport;
  final DateTime? travelDate;
  final TimeOfDay? travelTime;
  final int numberOfPassengers;

  PaymentScreen({
    required this.flightType,
    this.departureCity,
    this.destinationCity,
    this.preferredAirport,
    this.travelDate,
    this.travelTime,
    required this.numberOfPassengers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade300, Colors.deepPurple.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Flight details section
            _buildFlightDetailsSection(),
            SizedBox(height: 20),

            // Payment Mode Dropdown
            _buildPaymentModeDropdown(),
            SizedBox(height: 20),

            // Proceed Button
            _buildProceedButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFlightDetailsSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 12.0,
            spreadRadius: 2.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Flight Details',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple),
          ),
          Divider(thickness: 2, color: Colors.deepPurple.shade200),
          Text('Flight Type: $flightType', style: TextStyle(fontSize: 16)),
          Text('Departure City: $departureCity', style: TextStyle(fontSize: 16)),
          Text('Destination City: $destinationCity', style: TextStyle(fontSize: 16)),
          Text('Preferred Airport: $preferredAirport', style: TextStyle(fontSize: 16)),
          Text('Travel Date: ${travelDate?.toLocal().toString().split(' ')[0]}', style: TextStyle(fontSize: 16)),
          Text('Travel Time: ${travelTime?.hour}:${travelTime?.minute.toString().padLeft(2, '0')}', style: TextStyle(fontSize: 16)),
          Text('Number of Passengers: $numberOfPassengers', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildPaymentModeDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 12.0,
            spreadRadius: 2.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Select Payment Mode:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          DropdownButton<String>(
            isExpanded: true,
            items: <String>['Credit Card', 'PayPal', 'M-Pesa']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(fontSize: 16)),
              );
            }).toList(),
            onChanged: (String? newValue) {
              // Handle payment mode selection
            },
            hint: Text('Choose payment mode', style: TextStyle(fontSize: 16)),
            underline: Container(
              height: 2,
              color: Colors.deepPurple,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProceedButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white70,
        padding: EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: () {
        _showConfirmationDialog(context);
      },
      child: Center(
        child: Text(
          'Proceed to Payment',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Payment'),
          content: Text('Are you sure you want to proceed with the payment?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _showPaymentSuccessDialog(context); // Show success dialog
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _showPaymentSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Successful'),
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 30),
              SizedBox(width: 10),
              Text('Your payment was successful!', style: TextStyle(fontSize: 16)),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showPaymentCancelledDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Cancelled'),
          content: Row(
            children: [
              Icon(Icons.cancel, color: Colors.red, size: 30),
              SizedBox(width: 10),
              Text('Your payment has been cancelled.', style: TextStyle(fontSize: 16)),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
