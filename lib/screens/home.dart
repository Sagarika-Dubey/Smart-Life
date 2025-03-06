import 'package:flutter/material.dart';
import 'package:smartlife/screens/all_devices.dart';
import 'package:smartlife/screens/energy_saving.dart';
import 'package:smartlife/screens/profile_page.dart';
import 'package:smartlife/screens/room.dart';
import 'package:smartlife/screens/room_settings.dart';
import 'package:smartlife/screens/scene.dart';
import 'package:smartlife/screens/smart.dart';
import 'package:smartlife/screens/me.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smartlife/screens/temp.dart';
import 'dart:core';

const String apiKey =
    "d0290b5d0ee000ec31806f19a5dc73f8"; // change with sirs api

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    RoomPage(),
    SceneScreen(),
    SmartScreen(),
    MeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 252, 236, 236),
              Color.fromARGB(255, 255, 255, 255)
            ],
          ),
        ),
        child: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.meeting_room), label: "Room"),
          BottomNavigationBarItem(icon: Icon(Icons.check_box), label: "Scene"),
          BottomNavigationBarItem(icon: Icon(Icons.smart_toy), label: "Smart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me"),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double? temperature;
  String weatherDescription = "";

  @override
  void initState() {
    super.initState();
    getUserLocation();
  }

  Future<void> getWeatherData(double lat, double lon) async {
    final url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (!mounted) return;

        setState(() {
          temperature = data["main"]["temp"];
          weatherDescription = data["weather"][0]["description"];
        });
      }
    } catch (e) {
      print("Error fetching weather data: $e");
    }
  }

  Future<void> getUserLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return;

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      if (!mounted) return;

      getWeatherData(position.latitude, position.longitude);
    } catch (e) {
      print("Error fetching location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                    icon: Icon(Icons.person_2_rounded),
                  ),
                  Text("Hi User!"),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Home',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                PopupMenuButton<String>(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  icon: Icon(Icons.more_vert), // Three-dot menu icon
                  onSelected: (String value) {
                    if (value == 'all_devices') {
                      print("Navigating to All Devices");
                      // Implement navigation logic here
                    } else if (value == 'room_list') {
                      print("Navigating to Room List");
                      // Implement navigation logic here
                    } else if (value == 'manage_homepage') {
                      print("Navigating to Manage Homepage");
                      // Implement navigation logic here
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'all_devices',
                      child: ListTile(
                        leading: Icon(Icons.devices),
                        title: Text('All Devices'),
                        onTap: () {
                          Navigator.pop(
                              context); // Close the menu before navigating
                          print("Navigating to All Devices");
                          // Implement navigation logic here
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllDevicesScreen()));
                        },
                      ),
                    ),
                    PopupMenuItem(
                      value: 'room_list',
                      child: ListTile(
                        leading: Icon(Icons.meeting_room),
                        title: Text('Room List'),
                        onTap: () {
                          Navigator.pop(
                              context); // Close the menu before navigating
                          print("Navigating to Room List");
                          // Implement navigation logic here
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RoomPage()));
                        },
                      ),
                    ),
                    PopupMenuItem(
                      value: 'manage_homepage',
                      child: ListTile(
                        leading: Icon(Icons.home),
                        title: Text('Manage Homepage'),
                        onTap: () {
                          Navigator.pop(
                              context); // Close the menu before navigating
                          print("Navigating to Manage Homepage");
                          // Implement navigation logic here
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.lightbulb, color: Colors.blue),
              title: const Text("Try some new features",
                  style: TextStyle(fontSize: 17)),
              subtitle: const Text("Don't show again",
                  style: TextStyle(fontSize: 12)),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WeatherScreen()),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            'assets/images/sun.jpg',
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              temperature != null
                                  ? "${temperature?.toStringAsFixed(1)}°C"
                                  : "Loading...",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Card(
                      child: ListTile(
                        leading:
                            const Icon(Icons.flash_on, color: Colors.orange),
                        title: const Text("Energy Saving"),
                        onTap: () {
                          //print("Energy Saving tapped");
                          // Navigate or perform an action here
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EnergySavingPage()));
                        },
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading:
                            const Icon(Icons.grid_view, color: Colors.blue),
                        title: const Text("All Devices"),
                        onTap: () {
                          print("All Devices tapped");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllDevicesScreen()));
                          // Navigate or perform an action here
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.edit, size: 18),
                  SizedBox(width: 8),
                  Text("Edit"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
