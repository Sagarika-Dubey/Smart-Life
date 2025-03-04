import 'package:flutter/material.dart';

class EnvironmentalAbnormalitiesScreen extends StatefulWidget {
  @override
  _EnvironmentalAbnormalitiesScreenState createState() =>
      _EnvironmentalAbnormalitiesScreenState();
}

class _EnvironmentalAbnormalitiesScreenState
    extends State<EnvironmentalAbnormalitiesScreen> {
  String? selectedAlarm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Environmental Abnormalities",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildAlarmOption("Flooding alarm", "flooding",
                      Icons.water_drop, Colors.blue),
                  _buildAlarmOption("Gas alarm", "gas",
                      Icons.local_fire_department, Colors.orange),
                  _buildAlarmOption(
                      "Smoke alarm", "smoke", Icons.smoke_free, Colors.red),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectedAlarm == null ? null : () {},
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    selectedAlarm == null ? Colors.grey : Colors.blue,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey.shade400,
              ),
              child: Text("Next"),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey.shade100,
    );
  }

  Widget _buildAlarmOption(
      String title, String value, IconData icon, Color iconColor) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title),
      trailing: Radio<String>(
        value: value,
        groupValue: selectedAlarm,
        onChanged: (String? newValue) {
          setState(() {
            selectedAlarm = newValue;
          });
        },
      ),
    );
  }
}
