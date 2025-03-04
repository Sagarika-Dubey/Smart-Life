import 'package:flutter/material.dart';

class EmergencyCallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Emergency Call')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EmergencyAlarmPage()),
            );
          },
          child: Text('Emergency Call'),
        ),
      ),
    );
  }
}

class EmergencyAlarmPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Emergency Alarm')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Emergency Alarm',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 6.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.sos, color: Colors.blue),
                    title: Text('SOS'),
                    trailing:
                        Radio(value: 1, groupValue: null, onChanged: (val) {}),
                  ),
                  ListTile(
                    leading: Icon(Icons.add, color: Colors.red),
                    title: Text('Urgent'),
                    trailing:
                        Radio(value: 2, groupValue: null, onChanged: (val) {}),
                  ),
                  ListTile(
                    leading:
                        Icon(Icons.local_fire_department, color: Colors.orange),
                    title: Text('Fire alarm'),
                    trailing:
                        Radio(value: 3, groupValue: null, onChanged: (val) {}),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
