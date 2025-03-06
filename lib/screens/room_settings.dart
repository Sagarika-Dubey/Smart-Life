import 'package:flutter/material.dart';
import 'dart:math' as math;

class RoomScreen extends StatefulWidget {
  const RoomScreen({super.key});

  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  Map<String, bool> deviceStates = {
    'TV': false,
    'Rope Light': false,
    'Light': false,
    'Music System': false,
    'AC': false,
    'Fan': false,
  };

  // Added device types to determine which settings to show
  Map<String, String> deviceTypes = {
    'TV': 'entertainment',
    'Rope Light': 'lighting',
    'Light': 'lighting',
    'Music System': 'entertainment',
    'AC': 'climate',
    'Fan': 'climate',
  };

  Map<String, Function(BuildContext)> deviceSettingsActions = {};

  @override
  void initState() {
    super.initState();

    deviceSettingsActions = {
      'TV': (context) => _navigateToSettings(context, 'TV'),
      'Rope Light': (context) => _navigateToSettings(context, 'Rope Light'),
      'Light': (context) => _navigateToSettings(context, 'Light'),
      'Music System': (context) => _navigateToSettings(context, 'Music System'),
      'AC': (context) => _navigateToSettings(context, 'AC'),
      'Fan': (context) => _navigateToSettings(context, 'Fan'),
    };
  }

  void _navigateToSettings(BuildContext context, String device) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DeviceSettingsScreen(
          deviceName: device,
          deviceType: deviceTypes[device] ?? 'other',
          initialState: deviceStates[device]!,
          onDelete: () {
            setState(() {
              deviceStates.remove(device);
              deviceTypes.remove(device);
              deviceSettingsActions.remove(device);
            });
            Navigator.pop(context);
          },
          onRename: (newName) {
            if (newName.isNotEmpty && !deviceStates.containsKey(newName)) {
              setState(() {
                bool? state = deviceStates.remove(device);
                String? type = deviceTypes.remove(device);
                Function(BuildContext)? action =
                    deviceSettingsActions.remove(device);
                deviceStates[newName] = state!;
                deviceTypes[newName] = type!;
                deviceSettingsActions[newName] = action!;
              });
            }
          },
          onToggle: (newState) {
            setState(() {
              deviceStates[device] = newState;
            });
          },
        ),
      ),
    );
  }

  void toggleDevice(String device) {
    setState(() {
      deviceStates[device] = !deviceStates[device]!;
    });
  }

  void addDevice() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController controller = TextEditingController();
        String selectedType = 'other';

        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text('Add Device'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(hintText: 'Enter device name'),
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedType,
                  decoration: InputDecoration(
                    labelText: 'Device Type',
                  ),
                  items: [
                    DropdownMenuItem(
                        value: 'lighting', child: Text('Lighting')),
                    DropdownMenuItem(
                        value: 'climate', child: Text('Climate Control')),
                    DropdownMenuItem(
                        value: 'entertainment', child: Text('Entertainment')),
                    DropdownMenuItem(value: 'other', child: Text('Other')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedType = value!;
                    });
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    this.setState(() {
                      deviceStates[controller.text] = false;
                      deviceTypes[controller.text] = selectedType;
                      deviceSettingsActions[controller.text] = (context) {
                        _navigateToSettings(context, controller.text);
                      };
                    });
                  }
                  Navigator.pop(context);
                },
                child: Text('Add'),
              ),
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Room Management')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(onPressed: () {}, child: Text('Scene')),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: deviceStates.keys.map((device) {
                IconData iconData;
                switch (deviceTypes[device]) {
                  case 'lighting':
                    iconData = Icons.lightbulb_outline;
                    break;
                  case 'climate':
                    iconData = Icons.thermostat;
                    break;
                  case 'entertainment':
                    iconData = Icons.tv;
                    break;
                  default:
                    iconData = Icons.devices;
                }

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: Icon(iconData),
                    title: Text(device),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Switch(
                          value: deviceStates[device]!,
                          onChanged: (value) => toggleDevice(device),
                        ),
                        IconButton(
                          icon: Icon(Icons.settings),
                          onPressed: () {
                            deviceSettingsActions[device]?.call(context);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addDevice,
        child: Icon(Icons.add),
      ),
    );
  }
}

class DeviceSettingsScreen extends StatefulWidget {
  final String deviceName;
  final String deviceType;
  final bool initialState;
  final VoidCallback onDelete;
  final Function(String) onRename;
  final Function(bool) onToggle;

  DeviceSettingsScreen({
    required this.deviceName,
    required this.deviceType,
    required this.initialState,
    required this.onDelete,
    required this.onRename,
    required this.onToggle,
  });

  @override
  _DeviceSettingsScreenState createState() => _DeviceSettingsScreenState();
}

class _DeviceSettingsScreenState extends State<DeviceSettingsScreen> {
  late String deviceName;
  late bool deviceState;
  TextEditingController renameController = TextEditingController();

  // New state variables for additional features
  double brightness = 100;
  TimeOfDay? scheduleOn;
  TimeOfDay? scheduleOff;
  bool isScheduleEnabled = false;
  late String selectedMode;
  Color selectedColor = Colors.white;
  late List<String> availableModes;

  // Mock data for energy usage
  List<double> dailyUsageData =
      List.generate(7, (index) => math.Random().nextDouble() * 5);

  @override
  void initState() {
    super.initState();
    deviceName = widget.deviceName;
    deviceState = widget.initialState;
    renameController.text = deviceName;

    // Initialize modes based on device type
    if (widget.deviceType == 'climate') {
      availableModes = ['Auto', 'Cool', 'Heat', 'Fan', 'Eco'];
    } else if (widget.deviceType == 'lighting') {
      availableModes = ['Normal', 'Reading', 'Movie', 'Night', 'Party'];
    } else if (widget.deviceType == 'entertainment') {
      availableModes = ['Standard', 'Movie', 'Game', 'Music', 'Sports'];
    } else {
      availableModes = ['Standard', 'Eco', 'Sleep', 'Away', 'Custom'];
    }

    // Set initial mode (must match one of the values in availableModes)
    selectedMode = availableModes[0];
  }

  void _renameDevice() {
    String newName = renameController.text.trim();
    if (newName.isNotEmpty && newName != deviceName) {
      widget.onRename(newName);
      setState(() {
        deviceName = newName;
      });
      Navigator.pop(context);
    }
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Device'),
        content: Text('Are you sure you want to delete $deviceName?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              widget.onDelete();
              Navigator.pop(context);
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? (scheduleOn ?? TimeOfDay.now())
          : (scheduleOff ?? TimeOfDay.now()),
    );

    if (picked != null) {
      setState(() {
        if (isStartTime) {
          scheduleOn = picked;
        } else {
          scheduleOff = picked;
        }
      });
    }
  }

  Future<void> _selectColor() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Color'),
          content: SingleChildScrollView(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _colorOption(Colors.white),
                _colorOption(Colors.red),
                _colorOption(Colors.orange),
                _colorOption(Colors.yellow),
                _colorOption(Colors.green),
                _colorOption(Colors.blue),
                _colorOption(Colors.indigo),
                _colorOption(Colors.purple),
                _colorOption(Colors.pink),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _colorOption(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
        Navigator.pop(context);
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: selectedColor == color ? Colors.black : Colors.grey,
            width: selectedColor == color ? 3 : 1,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget _buildEnergyUsageChart() {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final maxUsage = dailyUsageData.reduce(math.max);

    return Container(
      height: 200,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Energy Usage (kWh)',
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(
                7,
                (index) {
                  // Calculate a slightly shorter bar height to prevent overflow
                  final barHeight = (dailyUsageData[index] / maxUsage) *
                      110; // Reduced from 120
                  return Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize
                          .min, // Add this to minimize column height
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: barHeight,
                          width: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(height: 4),
                        Text(days[index], style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$deviceName Settings')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Settings
            Card(
              child: Column(
                children: [
                  ListTile(
                    title: Text('Device Name'),
                    subtitle: Text(deviceName),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Rename Device'),
                            content: TextField(controller: renameController),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: _renameDevice,
                                child: Text('Rename'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SwitchListTile(
                    title: Text('Power'),
                    value: deviceState,
                    onChanged: (value) {
                      setState(() {
                        deviceState = value;
                      });
                      widget.onToggle(value);
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            // Brightness/Intensity Control (for compatible devices)
            if (widget.deviceType == 'lighting' ||
                widget.deviceType == 'climate')
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.deviceType == 'lighting'
                            ? 'Brightness'
                            : 'Intensity',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(
                            widget.deviceType == 'lighting'
                                ? Icons.brightness_low
                                : Icons.speed,
                            size: 24,
                          ),
                          Expanded(
                            child: Slider(
                              value: brightness,
                              min: 0,
                              max: 100,
                              divisions: 10,
                              label: '${brightness.round()}%',
                              onChanged: deviceState
                                  ? (value) {
                                      setState(() {
                                        brightness = value;
                                      });
                                    }
                                  : null,
                            ),
                          ),
                          Icon(
                            widget.deviceType == 'lighting'
                                ? Icons.brightness_high
                                : Icons.speed,
                            size: 24,
                          ),
                        ],
                      ),
                      Center(
                        child: Text('${brightness.round()}%'),
                      ),
                    ],
                  ),
                ),
              ),

            SizedBox(height: 16),

            // Color Control (only for lighting devices)
            if (widget.deviceType == 'lighting')
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Color',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: selectedColor,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: deviceState ? _selectColor : null,
                            child: Text('Change Color'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            SizedBox(height: 16),

            // Mode Selection
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mode', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedMode,
                      decoration: InputDecoration(
                        labelText: 'Select Mode',
                        border: OutlineInputBorder(),
                      ),
                      items: availableModes.map((mode) {
                        return DropdownMenuItem(
                          value: mode,
                          child: Text(mode),
                        );
                      }).toList(),
                      onChanged: deviceState
                          ? (value) {
                              if (value != null) {
                                setState(() {
                                  selectedMode = value;
                                });
                              }
                            }
                          : null,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),

            // Schedule
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Schedule',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Switch(
                          value: isScheduleEnabled,
                          onChanged: (value) {
                            setState(() {
                              isScheduleEnabled = value;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    ListTile(
                      enabled: isScheduleEnabled,
                      title: Text('Turn On'),
                      subtitle: Text(scheduleOn != null
                          ? '${scheduleOn!.format(context)}'
                          : 'Not set'),
                      trailing: Icon(Icons.access_time),
                      onTap: isScheduleEnabled
                          ? () => _selectTime(context, true)
                          : null,
                    ),
                    ListTile(
                      enabled: isScheduleEnabled,
                      title: Text('Turn Off'),
                      subtitle: Text(scheduleOff != null
                          ? '${scheduleOff!.format(context)}'
                          : 'Not set'),
                      trailing: Icon(Icons.access_time),
                      onTap: isScheduleEnabled
                          ? () => _selectTime(context, false)
                          : null,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),

            // Energy Usage
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Energy Usage',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 16),
                    _buildEnergyUsageChart(),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Daily Average:'),
                        Text(
                            '${(dailyUsageData.reduce((a, b) => a + b) / 7).toStringAsFixed(2)} kWh'),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Weekly:'),
                        Text(
                            '${dailyUsageData.reduce((a, b) => a + b).toStringAsFixed(2)} kWh'),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),

            // Device Advanced Settings
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Advanced Settings',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 16),

                    // Auto-off timer
                    SwitchListTile(
                      title: Text('Auto-off Timer'),
                      subtitle: Text(
                          'Automatically turn off after 2 hours of inactivity'),
                      value: false,
                      onChanged: deviceState ? (value) {} : null,
                    ),

                    // Voice control
                    SwitchListTile(
                      title: Text('Voice Control'),
                      subtitle: Text('Control this device with voice commands'),
                      value: true,
                      onChanged: deviceState ? (value) {} : null,
                    ),

                    // Notification settings
                    ListTile(
                      title: Text('Notification Settings'),
                      subtitle: Text('Configure alerts and notifications'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      enabled: deviceState,
                      onTap: deviceState
                          ? () {
                              // Show notification settings dialog
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Notification Settings'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SwitchListTile(
                                        title: Text('Status Change Alerts'),
                                        value: true,
                                        onChanged: (value) {},
                                      ),
                                      SwitchListTile(
                                        title: Text('Energy Usage Alerts'),
                                        value: false,
                                        onChanged: (value) {},
                                      ),
                                      SwitchListTile(
                                        title: Text('Maintenance Reminders'),
                                        value: true,
                                        onChanged: (value) {},
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('Close'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          : null,
                    ),

                    // Firmware update
                    ListTile(
                      title: Text('Firmware'),
                      subtitle: Text('v2.0.1 (Up to date)'),
                      trailing: TextButton(
                        onPressed: deviceState
                            ? () {
                                // Show firmware update dialog
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Firmware Status'),
                                    content: Text(
                                        'Your device firmware is up to date.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            : null,
                        child: Text('Check for Updates'),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),

            // Device Automation
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Automation',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 16),
                    ListTile(
                      title: Text('Create Automation'),
                      subtitle:
                          Text('Set up triggers and actions for this device'),
                      trailing: Icon(Icons.add),
                      enabled: deviceState,
                      onTap: deviceState
                          ? () {
                              // Show automation dialog
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Create Automation'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      DropdownButtonFormField<String>(
                                        decoration: InputDecoration(
                                          labelText: 'Trigger',
                                          border: OutlineInputBorder(),
                                        ),
                                        value: 'Time',
                                        items: [
                                          DropdownMenuItem(
                                              value: 'Time',
                                              child: Text('Time')),
                                          DropdownMenuItem(
                                              value: 'Location',
                                              child: Text('Location')),
                                          DropdownMenuItem(
                                              value: 'Device',
                                              child: Text('Another Device')),
                                          DropdownMenuItem(
                                              value: 'Voice',
                                              child: Text('Voice Command')),
                                        ],
                                        onChanged: (value) {},
                                      ),
                                      SizedBox(height: 16),
                                      DropdownButtonFormField<String>(
                                        decoration: InputDecoration(
                                          labelText: 'Action',
                                          border: OutlineInputBorder(),
                                        ),
                                        value: 'TurnOn',
                                        items: [
                                          DropdownMenuItem(
                                              value: 'TurnOn',
                                              child: Text('Turn On')),
                                          DropdownMenuItem(
                                              value: 'TurnOff',
                                              child: Text('Turn Off')),
                                          DropdownMenuItem(
                                              value: 'SetMode',
                                              child: Text('Set Mode')),
                                          DropdownMenuItem(
                                              value: 'Adjust',
                                              child: Text('Adjust Settings')),
                                        ],
                                        onChanged: (value) {},
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Automation created successfully'),
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                      },
                                      child: Text('Create'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          : null,
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Active Automations'),
                      subtitle: Text('None'),
                      enabled: deviceState,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24),

            // Delete Button
            Center(
              child: ElevatedButton(
                onPressed: _confirmDelete,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text('Delete Device'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
