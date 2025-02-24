import 'package:flutter/material.dart';
import 'package:smartlife/screens/profile_page.dart';
import 'package:smartlife/screens/qrscanner_screen.dart';
import './setting_screen.dart';

class MeScreen extends StatefulWidget {
  @override
  _MeScreenState createState() => _MeScreenState();
}

class _MeScreenState extends State<MeScreen> {
  String _nickname = "Tap to Set Nickname"; // Default nickname

  void _navigateToProfile(BuildContext context) async {
    final newNickname = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage()),
    );

    if (newNickname != null && newNickname is String) {
      setState(() {
        _nickname = newNickname; // Update the nickname dynamically
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 199, 200, 201),
              Color.fromARGB(255, 255, 255, 255)
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.qr_code_scanner),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QRScannerScreen()),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsScreen()),
                      );
                    },
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => _navigateToProfile(context),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  title: Text(
                    _nickname, // Display updated nickname
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Third-Party Services",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.arrow_forward_ios, size: 16),
                            onPressed: () {
                              print("Third-Party Services tapped");
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _serviceButton(
                              'assets/images/alexa-logo.png', 'Alexa'),
                          _serviceButton('assets/images/google_assistant.webp',
                              'Google Assistant'),
                          _serviceButton(
                              'assets/images/SMart_Things.png', 'SmartThings'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
                color: Colors.white,
                child: Column(
                  children: [
                    _menuItem('assets/images/home.png', "Home Management"),
                    _menuItem('assets/images/message.png', "Message Center"),
                    _menuItem('assets/images/help_center.png', "Help Center"),
                    _menuItem('assets/images/android_auto.png', "Android Auto"),
                    _menuItem('assets/images/google_home.webp',
                        "Google Home Devices"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _serviceButton(String assetPath, String label) {
    return GestureDetector(
      onTap: () {
        print("$label clicked");
      },
      child: Column(
        children: [
          Image.asset(assetPath, width: 50, height: 50),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _menuItem(String assetPath, String title) {
    return ListTile(
      leading: Image.asset(assetPath, width: 30, height: 30),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        print("$title clicked");
      },
    );
  }
}
