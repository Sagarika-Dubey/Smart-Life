import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      home: MoreFeaturesScreen(),
    );
  }
}

class MoreFeaturesScreen extends StatefulWidget {
  const MoreFeaturesScreen({super.key});

  @override
  _MoreFeaturesScreenState createState() => _MoreFeaturesScreenState();
}

class _MoreFeaturesScreenState extends State<MoreFeaturesScreen> {
  bool autoAddDevice = true;
  bool scanDevice = true;
  bool autoAddNewDevices = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("More Features"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildFeatureTile(
              title: "Auto Add Discovered Device",
              subtitle: "Auto add a paired device, no need to confirm it.",
              value: autoAddDevice,
              onChanged: (val) {
                setState(() {
                  autoAddDevice = val;
                });
              },
            ),
            _buildFeatureTile(
              title: "Scan device in homepage",
              subtitle: "Auto display discovered devices on the homepage.",
              value: scanDevice,
              onChanged: (val) {
                setState(() {
                  scanDevice = val;
                });
              },
            ),
            _buildFeatureTile(
              title: "Auto Add New Devices to Homepage",
              subtitle:
                  "Enabling this will automatically add new devices to the custom homepage.",
              value: autoAddNewDevices,
              onChanged: (val) {
                setState(() {
                  autoAddNewDevices = val;
                });
              },
            ),
            SizedBox(height: 20),
            ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              tileColor: Colors.blue.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: Text(
                "Home Network Topology",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                // Navigate to next screen
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(color: Colors.grey[700])),
                ],
              ),
            ),
            Switch(
              value: value,
              onChanged: onChanged,
              activeColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
