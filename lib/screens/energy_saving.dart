import 'package:flutter/material.dart';
import 'package:smartlife/screens/device%20power.dart';

class EnergySavingPage extends StatelessWidget {
  const EnergySavingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20), // Spacing from top

              // Close Button
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.close, size: 30, color: Colors.black54),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              SizedBox(height: 20), // Spacing

              // Energy Saving Icon with Background
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/images/power_save.avif', // Background image (use an appropriate asset)
                      width: 200,
                    ),
                    //Container(
                    //width: 100,
                    //height: 100,
                    //decoration: BoxDecoration(
                    //shape: BoxShape.circle,
                    //color: Colors.blue.shade700,
                    //),
                    //child: Icon(Icons.bolt, size: 50, color: Colors.white),
                    //),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Title
              Text(
                "Energy Saving",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: 10),

              // Description
              Text(
                "Provides statistical analysis of device electricity usage in your home, helping you optimize your electricity usage with electricity-saving suggestions and automated electricity-saving services.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),

              SizedBox(height: 10),

              Text(
                "The device power varies depending on the usage status, so the estimation of some devices might deviate. Currently, some devices do not support metering. You will be informed when they are integrated.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),

              Spacer(), // Pushes content up

              // Got It Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: () {
                    //print("Got It button pressed");
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DevicePowerPage()));
                  },
                  child: Text(
                    "Got It",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),

              SizedBox(height: 20), // Bottom spacing
            ],
          ),
        ),
      ),
    );
  }
}
