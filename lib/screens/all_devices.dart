import 'package:flutter/material.dart';
import './add_device.dart';

class AllDevicesScreen extends StatefulWidget {
  const AllDevicesScreen({super.key});

  @override
  _AllDevicesScreenState createState() => _AllDevicesScreenState();
}

class _AllDevicesScreenState extends State<AllDevicesScreen> {
  List<String> devices = []; // Stores added devices

  void _navigateToAddDeviceScreen() async {
    final newDevice = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddDeviceScreen()),
    );

    if (newDevice != null) {
      setState(() {
        devices.add(newDevice); // Update the list when a new device is added
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Devices"), actions: [
        TextButton(
            onPressed: () {},
            child: Text("Manage", style: TextStyle(color: Colors.blue)))
      ]),
      body: devices.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/images/empty_box.png",
                      height: 100), // Use a placeholder image
                  Text("No devices"),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _navigateToAddDeviceScreen,
                    child: Text("Add Device"),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: devices.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(devices[index]),
                  trailing: Icon(Icons.bluetooth),
                );
              },
            ),
    );
  }
}
