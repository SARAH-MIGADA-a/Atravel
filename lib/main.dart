import 'package:flutter/material.dart';
import 'screens/splash_screen.dart'; // Import the splash screen
import 'screens/home_screen.dart';
import 'screens/flight_info_screen.dart';
import 'screens/flight_history_screen.dart';
import 'screens/airport_info_screen.dart';
import 'screens/booking_screen.dart';
import 'screens/user_profile_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/help_support_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/payment_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false; // Default to light mode

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode; // Toggle the theme
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ATravel',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(), // Set theme based on the toggle
      initialRoute: '/splash', // Set the initial route to the splash screen
      routes: {
        '/splash': (context) => SplashScreen(), // Add splash screen route
        '/': (context) => HomeScreen(),
        '/flightInfo': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return FlightInfoScreen(
            flightType: args['flightType'],
            numberOfPassengers: args['numberOfPassengers'],
          );
        },
        '/flightHistory': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return FlightHistoryScreen(
            flightType: args['flightType'],
            numberOfPassengers: args['numberOfPassengers'],
          );
        },
        '/airportInfo': (context) => AirportInfoScreen(),
        '/booking': (context) => BookingScreen(),
        '/user_profile': (context) => UserProfileScreen(
          username: 'Sarah Migada',
          email: 'sarah@gmail.com',
          phoneNumber: '123-456-7890',
          address: '123 Main St, Anytown, USA',
          dateOfBirth: '01/01/1990',
          profilePictureUrl: 'https://example.com/profile.jpg',
        ),
        '/settings': (context) => SettingsScreen(
          onToggleTheme: _toggleTheme, // Pass the toggle function to the settings screen
        ),
        '/help_support': (context) => HelpSupportScreen(),
        '/notifications': (context) => NotificationScreen(),
        '/payment': (context) => PaymentScreen(
          flightType: '',
          numberOfPassengers: 1,
        ),
      },
    );
  }
}
