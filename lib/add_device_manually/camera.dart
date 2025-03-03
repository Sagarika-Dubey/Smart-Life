import 'package:flutter/material.dart';
import 'package:smartlife/add_device_manually/next_step.dart';

class cameraPage extends StatefulWidget {
  @override
  _cameraPageState createState() => _cameraPageState();
}

class _cameraPageState extends State<cameraPage> {
  final List<Map<String, dynamic>> categories = [
    {
      "mainCategory": "Camera and Lock",
      "subCategories": [
        {
          "title": "Camera",
          "devices": [
            {"name": "Smart Camera(Wi-Fi)", "icon": Icons.power},
            {"name": "Smart Camera(2.4GHz & 5GHz)", "icon": Icons.power},
            {"name": "Smart Camera(BLE)", "icon": Icons.power},
            {"name": "Indoor PTZ Camera (Wi-Fi)", "icon": Icons.power},
            {"name": "PTZ Camera (Wi-Fi)", "icon": Icons.power},
            {"name": "DoorBell Camera", "icon": Icons.power},
            {"name": "Smart DoorBell", "icon": Icons.power}
          ],
        },
        {
          "title": "Smart LocLock",
          "devices": [
            {"name": "Lock(BLE+Wi-Fi)", "icon": Icons.power},
            {"name": "Lock(Wi-Fi)", "icon": Icons.power},
            {"name": "Lock (Zigbee)", "icon": Icons.power},
            {"name": "Lock (BLE)", "icon": Icons.power},
          ],
        },
      ],
    }
  ];

  void _navigateToNextScreen(BuildContext context, String deviceName) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MultiPageScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Device")),
      body: ListView(
        children: categories.map((category) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  category["mainCategory"],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              ...category["subCategories"].map<Widget>((subCategory) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subCategory["title"],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 5),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: subCategory["devices"].length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          var device = subCategory["devices"][index];
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () => _navigateToNextScreen(
                                    context, device["name"]),
                                child: Icon(device["icon"],
                                    size: 40, color: Colors.blue),
                              ),
                              SizedBox(height: 5),
                              Text(
                                device["name"],
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                );
              }).toList(),
            ],
          );
        }).toList(),
      ),
    );
  }
}
