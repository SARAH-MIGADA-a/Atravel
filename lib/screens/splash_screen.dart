import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  // Variables to control the typewriter animation
  String _displayedText = "";
  int _textIndex = 0;
  Timer? _timer;

  // List of texts for each slide
  final List<String> _texts = [
    "Welcome to ATravel 🌍 Discover the magic of East Africa",
    "Book your Flight to East Africa!",
    "Ready to Explore the epitome of Africa?"
  ];

  @override
  void initState() {
    super.initState();
    _startTypewriterAnimation(0); // Start animation for the first slide
  }

  // Function to start the typewriter animation
  void _startTypewriterAnimation(int pageIndex) {
    _textIndex = 0;
    _displayedText = "";
    _timer?.cancel(); // Cancel any previous timer
    _timer = Timer.periodic(Duration(milliseconds: 50), (timer) {  // Speeding up animation
      if (_textIndex < _texts[pageIndex].length) {
        setState(() {
          _displayedText += _texts[pageIndex][_textIndex];
          _textIndex++;
        });
      } else {
        timer.cancel(); // Stop the timer once the full text is displayed
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel(); // Dispose the timer to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // PageView for sliding through the background images
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
                _startTypewriterAnimation(index); // Restart the typewriter animation on page change
              });
            },
            children: [
              // First slide
              SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/splash_screen1.webp'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // Second slide
              SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/splash_screen2.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // Third slide with Get Started button
              SafeArea(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/splash_screen3.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Corrected Get Started button placement
                    Positioned(
                      bottom: 100,
                      left: MediaQuery.of(context).size.width * 0.25, // Center the button
                      right: MediaQuery.of(context).size.width * 0.25,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/'); // Navigate to home screen
                        },
                        child: Text('Get Started'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, // Button color
                          foregroundColor: Colors.black, // Text color
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                          textStyle: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Typewriter text at the top of each slide, styled and vertically aligned
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: Container(
              child: Text(
                _displayedText,
                style: TextStyle(
                  fontSize: 42, // Increased text size
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto', // Use an interesting font
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,  // Ensure overflow text is hidden as desired
              ),
            ),
          ),
          // Dots Indicator
          Positioned(
            bottom: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  height: 12,
                  width: _currentPage == index ? 12 : 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? Colors.white : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
