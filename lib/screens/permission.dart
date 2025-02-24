import 'package:flutter/material.dart';
import 'package:smartlife/screens/home.dart';

class Permission extends StatefulWidget {
  const Permission({super.key});

  @override
  State<Permission> createState() => _PermissionState();
}

class _PermissionState extends State<Permission> {
  bool serviceMaintenance = true;
  bool personalizedRecommendations = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Text(
                "To provide you with better services, we request the following permissions:",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Image.asset('assets/images/permission.avif', height: 150),
              SizedBox(height: 10),
              Text(
                "The following functions can be enabled or disabled in the app settings.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 20),
              _buildPermissionTile(
                "Service Maintenance & Improvement Activity",
                "Allow us to collect data related to product usage. Basic functionality will still be available if permissions are disabled, but the experience optimization policy based on data preferences will be ineffective.",
                serviceMaintenance,
                (bool? value) {
                  setState(() {
                    serviceMaintenance = value ?? false;
                  });
                },
              ),
              SizedBox(height: 10),
              _buildPermissionTile(
                "Personalized Recommendations",
                "Allow us to recommend content to you, including experience optimization, scene linkage, and best usage advice for devices. If you disable this function, we will no longer send you potentially interesting content.",
                personalizedRecommendations,
                (bool? value) {
                  setState(() {
                    personalizedRecommendations = value ?? false;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 103, 104, 105),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text("Go to App", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPermissionTile(String title, String description, bool value,
      ValueChanged<bool?>? onChanged) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: Colors.blue,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text(description, style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
