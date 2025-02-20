import 'package:flutter/material.dart';
import 'package:smartlife/screens/room.dart';
import 'package:smartlife/screens/scene.dart';
import 'package:smartlife/screens/smart.dart';
import './me.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    RoomScreen(),
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
              Color.fromARGB(255, 202, 227, 243),
              Color.fromARGB(255, 255, 255, 255)
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: IndexedStack(
                index: _currentIndex,
                children: _screens,
              ),
            ),
          ],
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

class HomeScreen extends StatelessWidget {
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
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.person_2_rounded),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add),
              ),
            ],
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'My Home..',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.lightbulb, color: Colors.blue),
                  title: const Text(
                    "Learn about the new DIY homepage",
                    style: TextStyle(fontSize: 15),
                  ),
                  subtitle: const Text(
                    "Don't show again",
                    style: TextStyle(fontSize: 10),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        15), // Adjust for more or less rounding
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        15), // Ensures the image follows the rounded corners
                    child: SizedBox(
                      width: double.infinity, // Makes the card take full width
                      child: Image.asset(
                        'assets/images/sun.jpg',
                        height: 120,
                        fit: BoxFit
                            .cover, // Ensures the image fills the card properly
                      ),
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
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading:
                            const Icon(Icons.grid_view, color: Colors.blue),
                        title: const Text("All Devices"),
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
                padding: EdgeInsets.symmetric(
                    horizontal: 20, vertical: 12), // Adjust padding
              ),
              child: Row(
                mainAxisSize: MainAxisSize
                    .min, // Ensures the button is only as wide as needed
                children: [
                  Icon(Icons.edit, size: 18), // Pencil icon
                  SizedBox(width: 8), // Space between icon and text
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
