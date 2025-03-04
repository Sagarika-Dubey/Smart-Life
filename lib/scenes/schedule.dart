import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AutomationScreen extends StatefulWidget {
  @override
  _AutomationScreenState createState() => _AutomationScreenState();
}

class _AutomationScreenState extends State<AutomationScreen> {
  List<Map<String, dynamic>> automations = [];

  @override
  void initState() {
    super.initState();
    _loadAutomations();
  }

  Future<void> _loadAutomations() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? storedAutomations = prefs.getStringList('automations') ?? [];

    setState(() {
      automations = storedAutomations
          .map((automation) => jsonDecode(automation) as Map<String, dynamic>)
          .toList();
    });
  }

  Future<void> _addAutomation(Map<String, dynamic> newAutomation) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? storedAutomations = prefs.getStringList('automations') ?? [];
    storedAutomations.add(jsonEncode(newAutomation));
    await prefs.setStringList('automations', storedAutomations);

    setState(() {
      automations.add(newAutomation);
    });
  }

  void _openAutomationPopup() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: SetAutomationScreen(
            onAutomationSaved: (automation) {
              if (automation != null) {
                _addAutomation(automation);
              }
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Automations")),
      body: automations.isEmpty
          ? Center(child: Text("No automations added yet"))
          : ListView.builder(
              itemCount: automations.length,
              itemBuilder: (context, index) {
                final automation = automations[index];
                final device = automation['device'];
                final status = automation['status'] ? "On" : "Off";
                final time = automation['time'];

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text("$device - $status"),
                    subtitle: Text("Time: ${time['hour']}:${time['minute']}"),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAutomationPopup,
        child: Icon(Icons.add),
      ),
    );
  }
}

class SetAutomationScreen extends StatefulWidget {
  final Function(Map<String, dynamic>?)? onAutomationSaved;

  SetAutomationScreen({this.onAutomationSaved});

  @override
  _SetAutomationScreenState createState() => _SetAutomationScreenState();
}

class _SetAutomationScreenState extends State<SetAutomationScreen> {
  final TextEditingController _deviceController = TextEditingController();
  bool isDeviceOn = false;
  TimeOfDay? selectedTime;
  bool is24HourFormat = false;

  Future<void> _pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(alwaysUse24HourFormat: is24HourFormat),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  void _saveAutomation() {
    if (_deviceController.text.isNotEmpty && selectedTime != null) {
      Map<String, dynamic> newAutomation = {
        'device': _deviceController.text,
        'status': isDeviceOn,
        'time': {'hour': selectedTime!.hour, 'minute': selectedTime!.minute},
      };

      widget.onAutomationSaved?.call(newAutomation);
      Navigator.pop(context); // Close popup
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Please enter a device name and select a time!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.card,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Set Automation",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TextField(
              controller: _deviceController,
              decoration: InputDecoration(
                labelText: "Enter Device Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
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
              onPressed: _pickTime,
              child: Text(selectedTime == null
                  ? "Select Time"
                  : "Time: ${selectedTime!.format(context)}"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("AM/PM"),
                Switch(
                  value: is24HourFormat,
                  onChanged: (bool value) {
                    setState(() {
                      is24HourFormat = value;
                    });
                  },
                ),
                Text("24-Hour"),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: _saveAutomation,
                  child: Text("Save"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
