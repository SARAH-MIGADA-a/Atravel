import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import your HomeScreen

class LoginSignUpScreen extends StatefulWidget {
  @override
  _LoginSignUpScreenState createState() => _LoginSignUpScreenState();
}

class _LoginSignUpScreenState extends State<LoginSignUpScreen> {
  bool _isLogin = true; // Toggle between login and sign-up

  void _toggleForm() {
    setState(() {
      _isLogin = !_isLogin; // Switch between login and sign-up
    });
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLogin ? 'Login' : 'Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLogin) _buildLoginForm() else _buildSignUpForm(),
            SizedBox(height: 20),
            TextButton(
              onPressed: _toggleForm,
              child: Text(
                _isLogin ? 'Don\'t have an account? Sign Up' : 'Already have an account? Login',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(labelText: 'Email'),
        ),
        TextField(
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Handle login functionality
            // If login is successful, navigate to home screen
            _navigateToHome();
          },
          child: Text('Login'),
        ),
      ],
    );
  }

  Widget _buildSignUpForm() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(labelText: 'Email'),
        ),
        TextField(
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        TextField(
          decoration: InputDecoration(labelText: 'Confirm Password'),
          obscureText: true,
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Handle sign-up functionality
            // If sign-up is successful, navigate to home screen
            _navigateToHome();
          },
          child: Text('Sign Up'),
        ),
      ],
    );
  }
}

