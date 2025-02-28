import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AutomationSceneScreen extends StatefulWidget {
  @override
  _AutomationSceneScreenState createState() => _AutomationSceneScreenState();
}

class _AutomationSceneScreenState extends State<AutomationSceneScreen> {
  final List<Map<String, dynamic>> scenes = [
    {
      'title': 'Launch Tap-to-Run',
      'subtitle': 'Turn off all lights with one tap.',
      'icon': Icons.touch_app
    },
    {
      'title': 'When weather changes',
      'subtitle': 'When local temperature > 28°C.',
      'icon': Icons.wb_sunny
    },
    {
      'title': 'When location changes',
      'subtitle': 'After you leave home.',
      'icon': Icons.location_on
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
      'title': 'Change Arm Mode',
      'subtitle': 'Arm Stay via Gateway.',
      'icon': Icons.security
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

  String? selectedDevice;
  bool isDeviceOn = false;
  TimeOfDay? selectedTime;
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
        savedAutomations = storedAutomations.map((data) {
          Map<String, dynamic> automation = jsonDecode(data);

          return {
            'device': automation['device'],
            'status': automation['status'],
            'time': TimeOfDay(
              hour: automation['time']['hour'],
              minute: automation['time']['minute'],
            ),
          };
        }).toList();
      });
    }
  }

  Future<void> _saveAutomation() async {
    if (selectedDevice != null && selectedTime != null) {
      final prefs = await SharedPreferences.getInstance();

      // Create a new automation entry
      Map<String, dynamic> newAutomation = {
        'device': selectedDevice!,
        'status': isDeviceOn,
        'time': {
          'hour': selectedTime!.hour,
          'minute': selectedTime!.minute,
        },
      };

      // Convert all automations to JSON strings
      savedAutomations.add(newAutomation);
      List<String> storedAutomations =
          savedAutomations.map((automation) => jsonEncode(automation)).toList();

      // Save as List<String> in SharedPreferences
      await prefs.setStringList('automations', storedAutomations);

      setState(() {});
    }
  }

  void _showAutomationPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Set Automation"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                value: selectedDevice,
                hint: Text("Select Device"),
                onChanged: (value) {
                  setState(() {
                    selectedDevice = value;
                  });
                },
                items: ["Light", "Fan", "AC"].map((String device) {
                  return DropdownMenuItem<String>(
                    value: device,
                    child: Text(device),
                  );
                }).toList(),
              ),
              SwitchListTile(
                title: Text("Turn On"),
                value: isDeviceOn,
                onChanged: (bool value) {
                  setState(() {
                    isDeviceOn = value;
                  });
                },
              ),
              TextButton(
                onPressed: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    setState(() {
                      selectedTime = pickedTime;
                    });
                  }
                },
                child: Text(selectedTime == null
                    ? "Select Time"
                    : "Time: ${selectedTime!.format(context)}"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _saveAutomation();
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailScreen(title: scenes[index]['title']),
                      ),
                    );
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Set Custom Automation",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            ElevatedButton(
              onPressed: _showAutomationPopup,
              child: Text("Add Automation"),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: savedAutomations.length,
              itemBuilder: (context, index) {
                final automation = savedAutomations[index];
                return ListTile(
                  title: Text(
                      "${automation['device']} - ${(automation['status'] as bool) ? 'On' : 'Off'}"),
                  subtitle: Text(
                      "Time: ${(automation['time'] as TimeOfDay).format(context)}"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String title;
  DetailScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('Feature coming soon!')),
    );
  }
}
