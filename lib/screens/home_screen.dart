import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;

  // Categories: All, Recommended, Most Viewed
  final List<String> _categories = ["All", "Recommended", "Most Viewed"];

  // List of popular destinations
  final List<String> _places = [
    'Maasai Mara, Kenya',
    'Diani Beach, Kenya',
    'Mount Kenya, Kenya',
    'Lamu Island, Kenya',
    'Amboseli National Park, Kenya',
    'Serengeti National Park, Tanzania',
    'Zanzibar, Tanzania',
    'Mount Kilimanjaro, Tanzania',
    'Ngorongoro Crater, Tanzania',
    'Pemba Island, Tanzania',
    'Bwindi Impenetrable Forest, Uganda',
    'Lake Victoria, Uganda',
    'Murchison Falls, Uganda',
    'Queen Elizabeth National Park, Uganda',
    'Ssese Islands, Uganda',
    'Lake Tanganyika, Burundi',
    'Rusizi National Park, Burundi',
    'Kibira National Park, Burundi',
    'Saga Beach, Burundi',
    'Gitega National Museum, Burundi',
  ];

  final List<String> _filteredPlaces = [];

  // List of East African travel groups
  final List<String> _travelGroups = [
    'Kenya Adventure Group',
    'Tanzania Safari Group',
    'Uganda Wildlife Group',
    'Burundi Cultural Group',
    'Rwanda Explorer Group',
    'East African Beach Lovers'
  ];

  String? _selectedFromCountry;
  String? _selectedToCountry;
  final List<String> _countries = [
    'Kenya',
    'Uganda',
    'Rwanda',
    'Burundi',
    'Tanzania',
    'South Sudan' // Added South Sudan
  ];

  @override
  void initState() {
    super.initState();
    _filteredPlaces.addAll(_places); // Initialize with all places
  }

  void _filterPlaces(int index) {
    setState(() {
      _selectedCategoryIndex = index;
      _filteredPlaces.clear();
      if (index == 0) {
        // All places
        _filteredPlaces.addAll(_places);
      } else if (index == 1) {
        // Recommended places (first 10)
        _filteredPlaces.addAll(_places.take(10));
      } else if (index == 2) {
        // Most Viewed places (last 10)
        _filteredPlaces.addAll(_places.reversed.take(10));
      }
    });
  }

  // Clear selected countries after search
  void _clearSelectedCountries() {
    setState(() {
      _selectedFromCountry = null;
      _selectedToCountry = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ATravel'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/user_profile'); // Navigate to UserProfileScreen
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Text
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, Explore Beautiful East Africa!',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'We hope you find what you came for.',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            // Search Bar with Dropdowns
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        hintText: 'From',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      items: _countries.map((String country) {
                        return DropdownMenuItem<String>(
                          value: country,
                          child: Text(country),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedFromCountry = value;
                        });
                      },
                      value: _selectedFromCountry,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        hintText: 'To',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      items: _countries.map((String country) {
                        return DropdownMenuItem<String>(
                          value: country,
                          child: Text(country),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedToCountry = value;
                        });
                      },
                      value: _selectedToCountry,
                    ),
                  ),
                ],
              ),
            ),
            // Search Flights Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  _clearSelectedCountries(); // Clear countries after search
                  Navigator.pushNamed(context, '/booking'); // Navigate to BookingScreen
                },
                child: Text('Search Flights'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            // New Text: "Enjoy the beauty of East Africa"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Enjoy the beauty of East Africa',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            // Categories (All, Recommended, Most Viewed)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(_categories.length, (index) {
                  return ChoiceChip(
                    label: Text(_categories[index]),
                    selected: _selectedCategoryIndex == index,
                    onSelected: (bool selected) {
                      _filterPlaces(index);
                    },
                  );
                }),
              ),
            ),
            // Horizontal Scrollable Destinations
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _filteredPlaces.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 150,
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/images/destination${index + 1}.jpg',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black.withOpacity(0.7),
                                      Colors.transparent,
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _filteredPlaces[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: _filteredPlaces[index].length > 15 ? 12 : 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 5.0,
                                        color: Colors.black,
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Travel Groups Section (Unchanged)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Popular Travel Groups',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ..._travelGroups.map((group) => ListTile(
              title: Text(group),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                // Travel Group click action (if any)
              },
            )),
          ],
        ),
      ),
      // Footer Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.red,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home'); // Home navigation
              break;
            case 1:
              Navigator.pushNamed(context, '/notifications'); // Notification screen
              break;
            case 2:
              Navigator.pushNamed(context, '/help_support'); // Help & Support screen
              break;
            case 3:
              Navigator.pushNamed(context, '/settings'); // Settings screen
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'Help & Support',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
