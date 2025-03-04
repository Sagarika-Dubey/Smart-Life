import 'package:flutter/material.dart';
import 'package:smartlife/scenes/abnormalities.dart';
import 'package:smartlife/scenes/emergency_call_page.dart';
import 'package:smartlife/scenes/intruder_alarm.dart';

class AlarmTriggerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alarm Trigger',
            style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading:
                        Icon(Icons.notifications_active, color: Colors.red),
                    title: Text('Emergency call'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EmergencyCallPage()));
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.warning, color: Colors.blue),
                    title: Text('Burglary alarm'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => IntruderAlarmPage()));
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.sensors_off, color: Colors.blue),
                    title: Text('Environmental abnormalities'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EnvironmentalAbnormalitiesScreen()));
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  children: [
                    TextSpan(
                      text:
                          "Before enabling 'Change Arming Mode' and 'Alarm Trigger' features, configure Smart Protect Settings and select devices to trigger alarms in the Security settings. ",
                    ),
                    TextSpan(
                      text: "Set up",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
