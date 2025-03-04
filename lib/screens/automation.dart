import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartlife/scenes/disaster_warming.dart';
import 'package:smartlife/scenes/when_alarm_tiggered.dart';
import 'package:smartlife/scenes/whether_change.dart';
import 'package:smartlife/screens/room.dart';
import 'dart:convert';
import '../scenes/schedule.dart';

class AutomationSceneScreen extends StatefulWidget {
  @override
  _AutomationSceneScreenState createState() => _AutomationSceneScreenState();
}

class _AutomationSceneScreenState extends State<AutomationSceneScreen> {
  final List<Map<String, dynamic>> scenes = [
    {
      'title': 'When weather changes',
      'subtitle': 'When local temperature > 28°C.',
      'icon': Icons.wb_sunny
    },
    {
      'title': 'Schedule',
      'subtitle': '7:00 a.m. every morning.',
      'icon': Icons.schedule
    },
    {
      'title': 'When device status changes',
      'subtitle': 'When an unusual activity is detected.',
      'icon': Icons.devices
    },
    {
      'title': 'When Alarm Triggered',
      'subtitle': 'Smoke Alarm Triggered.',
      'icon': Icons.notifications_active
    },
    {
      'title': 'Disaster Warning',
      'subtitle': '24-hour warning for heavy rain and snow.',
      'icon': Icons.warning
    },
  ];

  List<Map<String, dynamic>> savedAutomations = [];

  @override
  void initState() {
    super.initState();
    _loadSavedAutomations();
  }

  Future<void> _loadSavedAutomations() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? storedAutomations = prefs.getStringList('automations');

    if (storedAutomations != null) {
      setState(() {
        savedAutomations = storedAutomations
            .map((data) {
              try {
                // Explicitly cast the decoded map to `Map<String, dynamic>`
                Map<String, dynamic> automation =
                    jsonDecode(data) as Map<String, dynamic>;

                TimeOfDay? automationTime;
                if (automation.containsKey('time') &&
                    automation['time'] != null &&
                    automation['time'] is Map &&
                    automation['time'].containsKey('hour') &&
                    automation['time'].containsKey('minute')) {
                  automationTime = TimeOfDay(
                    hour: automation['time']['hour'],
                    minute: automation['time']['minute'],
                  );
                }

                return {
                  'device': automation['device'] ?? "Unknown Device",
                  'status': automation['status'] ?? false,
                  'time': automationTime, // Could be null, handled in UI
                };
              } catch (e) {
                print("Error parsing automation data: $e");
                return <String, dynamic>{}; // Return an empty valid map
              }
            })
            .where((element) => element.isNotEmpty)
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Automation & Scenes"),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Select a Scene",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: scenes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(scenes[index]['icon'], color: Colors.blue),
                  title: Text(scenes[index]['title']),
                  subtitle: Text(scenes[index]['subtitle']),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    switch (scenes[index]['title']) {
                      case 'When weather changes':
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WeatherChangeScreen()));
                        break;
                      case 'Schedule':
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SetAutomationScreen()));
                        break;
                      case 'When device status changes':
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RoomScreen()));
                        break;
                      case 'When Alarm Triggered':
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AlarmTriggerPage()));
                        break;
                      case 'Disaster Warning':
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DisasterWarming()));
                        break;
                      default:
                        break;
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
