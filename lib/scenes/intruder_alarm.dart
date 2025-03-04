import 'package:flutter/material.dart';

class IntruderAlarmPage extends StatefulWidget {
  @override
  _IntruderAlarmPageState createState() => _IntruderAlarmPageState();
}

class _IntruderAlarmPageState extends State<IntruderAlarmPage> {
  int? _selectedAlarm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Intruder Alarm'),
        actions: [
          TextButton(
            onPressed: _selectedAlarm != null ? () {} : null,
            child: Text(
              'Next',
              style: TextStyle(
                  color: _selectedAlarm != null ? Colors.blue : Colors.grey),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    leading: Icon(Icons.person, color: Colors.orange),
                    title: Text('Intrusion alert'),
                    subtitle: Text(
                        'Example: When the Smart Camera or PIR sensor detects an object.'),
                    trailing: Radio(
                      value: 1,
                      groupValue: _selectedAlarm,
                      onChanged: (int? val) {
                        setState(() {
                          _selectedAlarm = val;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.sensor_door, color: Colors.orange),
                    title: Text('Door magnetic alarm'),
                    subtitle: Text('Example: When the door sensor is opened.'),
                    trailing: Radio(
                      value: 2,
                      groupValue: _selectedAlarm,
                      onChanged: (int? val) {
                        setState(() {
                          _selectedAlarm = val;
                        });
                      },
                    ),
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
