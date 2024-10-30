import 'package:flutter/material.dart';
import 'flight_info_screen.dart';
import 'flight_history_screen.dart';
import 'airport_info_screen.dart';
import 'payment_screen.dart'; // Make sure to import your payment screen

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String _flightType = 'One-Way'; // Default flight type
  String? _selectedDepartureCity;
  String? _selectedDestinationCity;
  String? _selectedPreferredAirport;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  int _numberOfPassengers = 1;

  List<String> _departureCities = [];
  List<String> _destinationCities = [];
  List<String> _airports = [];

  // Store additional flights for Multi-City
  List<Flight> _additionalFlights = [];

  final Map<String, List<String>> _cityData = {
    'Nairobi': ['Nairobi', 'Mombasa', 'Eldoret', 'Kisumu'],
    'Mombasa': ['Mombasa', 'Nairobi'],
    'Dar es Salaam': ['Dar es Salaam', 'Arusha', 'Zanzibar'],
    'Arusha': ['Arusha', 'Dar es Salaam'],
    'Kampala': ['Kampala', 'Entebbe'],
    'Kigali': ['Kigali'],
    'Bujumbura': ['Bujumbura'],
    'Juba': ['Juba'],
    'Entebbe': ['Entebbe'],
    'Zanzibar': ['Zanzibar'],
  };

  final Map<String, List<String>> _airportData = {
    'Nairobi': ['Jomo Kenyatta International Airport', 'Wilson Airport'],
    'Mombasa': ['Moi International Airport'],
    'Dar es Salaam': ['Julius Nyerere International Airport'],
    'Arusha': ['Kilimanjaro International Airport'],
    'Kampala': ['Entebbe International Airport'],
    'Kigali': ['Kigali International Airport'],
    'Bujumbura': ['Bujumbura International Airport'],
    'Juba': ['Juba International Airport'],
    'Entebbe': ['Entebbe International Airport'],
    'Zanzibar': ['Zanzibar International Airport'],
  };

  @override
  void initState() {
    super.initState();
    _updateCities();
  }

  // Update the available airports based on the selected departure city
  void _updateAirports() {
    setState(() {
      _airports = _airportData[_selectedDepartureCity] ?? [];
      _selectedPreferredAirport = null;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime)
      setState(() {
        _selectedTime = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flight Booking'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(Icons.airplanemode_active),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FlightInfoScreen(
                    flightType: _flightType,
                    numberOfPassengers: _numberOfPassengers,
                  ),
                ),
              );

            },
          ),
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FlightHistoryScreen(
                    flightType: _flightType,
                    numberOfPassengers: _numberOfPassengers,
                  ),
                ),
              );

            },
          ),
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AirportInfoScreen(
                    selectedAirport: _selectedPreferredAirport, // This is from the BookingScreen
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Book Your Flight',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),

              // Flight Type Selector
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _flightTypeOption('One-Way'),
                  _flightTypeOption('Return'),
                  _flightTypeOption('Multi-City'),
                ],
              ),
              SizedBox(height: 30),

              // Departure City Dropdown
              DropdownButton<String>(
                hint: Text('Select Departure City'),
                value: _selectedDepartureCity,
                items: _departureCities.map((String city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDepartureCity = value;
                    _updateAirports(); // Update airports when city changes
                  });
                },
              ),
              SizedBox(height: 10),

              // Destination City Dropdown
              DropdownButton<String>(
                hint: Text('Select Destination City'),
                value: _selectedDestinationCity,
                items: _destinationCities.map((String city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDestinationCity = value;
                  });
                },
              ),
              SizedBox(height: 10),

              // Preferred Airport Dropdown
              DropdownButton<String>(
                hint: Text('Select Preferred Airport'),
                value: _selectedPreferredAirport,
                items: _airports.map((String airport) {
                  return DropdownMenuItem<String>(
                    value: airport,
                    child: Text(airport),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPreferredAirport = value;
                  });
                },
              ),
              SizedBox(height: 20),

              // Travel Date
              Text(
                'Select Travel Date:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[200],
                  ),
                  child: Text(
                    _selectedDate == null
                        ? 'Select Date'
                        : '${_selectedDate!.toLocal()}'.split(' ')[0],
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Travel Time
              Text(
                'Select Travel Time:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () => _selectTime(context),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[200],
                  ),
                  child: Text(
                    _selectedTime == null
                        ? 'Select Time'
                        : '${_selectedTime!.hour}:${_selectedTime!.minute.toString().padLeft(2, '0')}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Multi-City Add Flights Section
              if (_flightType == 'Multi-City') ...[
                Text(
                  'Additional Flights:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _additionalFlights.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Flight ${index + 1}'),
                            IconButton(
                              icon: Icon(Icons.remove_circle, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  _additionalFlights.removeAt(index);
                                });
                              },
                            ),
                          ],
                        ),
                        // Departure City Dropdown for Additional Flight
                        DropdownButton<String>(
                          hint: Text('Select Departure City'),
                          value: _additionalFlights[index].departureCity,
                          items: _departureCities.map((String city) {
                            return DropdownMenuItem<String>(
                              value: city,
                              child: Text(city),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _additionalFlights[index].departureCity = value;
                            });
                          },
                        ),
                        // Destination City Dropdown for Additional Flight
                        DropdownButton<String>(
                          hint: Text('Select Destination City'),
                          value: _additionalFlights[index].destinationCity,
                          items: _destinationCities.map((String city) {
                            return DropdownMenuItem<String>(
                              value: city,
                              child: Text(city),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _additionalFlights[index].destinationCity = value;
                            });
                          },
                        ),
                      ],
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _additionalFlights.add(Flight(departureCity: '', destinationCity: ''));
                    });
                  },
                  child: Text('Add Another Flight'),
                ),
              ],
              SizedBox(height: 20),

              // Number of Passengers
              Text(
                'Number of Passengers:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      if (_numberOfPassengers > 1) {
                        setState(() {
                          _numberOfPassengers--;
                        });
                      }
                    },
                  ),
                  Text(
                    _numberOfPassengers.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        _numberOfPassengers++;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Book Flight Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to Payment Screen with flightType
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentScreen(
                          flightType: _flightType,
                          numberOfPassengers: _numberOfPassengers, // Pass the number of passengers
                        ),
                      ),
                    );

                  },
                  child: Text('Book Flight'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _flightTypeOption(String type) {
    return ChoiceChip(
      label: Text(type),
      selected: _flightType == type,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _flightType = type;
          });
        }
      },
    );
  }

  void _updateCities() {
    // Update the available cities based on the flight type or any other logic
    setState(() {
      if (_flightType == 'One-Way' || _flightType == 'Return') {
        _departureCities = ['Nairobi', 'Mombasa', 'Dar es Salaam', 'Arusha', 'Kampala', 'Kigali'];
        _destinationCities = ['Nairobi', 'Mombasa', 'Dar es Salaam', 'Arusha', 'Kampala', 'Kigali'];
      } else if (_flightType == 'Multi-City') {
        _departureCities = ['Nairobi', 'Mombasa', 'Dar es Salaam', 'Arusha', 'Kampala', 'Kigali', 'Bujumbura', 'Juba'];
        _destinationCities = ['Nairobi', 'Mombasa', 'Dar es Salaam', 'Arusha', 'Kampala', 'Kigali', 'Bujumbura', 'Juba'];
      }
      _selectedDepartureCity = null;
      _selectedDestinationCity = null;
    });
  }
}

class Flight {
  String? departureCity;
  String? destinationCity;

  Flight({this.departureCity, this.destinationCity});
}
