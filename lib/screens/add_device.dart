import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class AddDeviceScreen extends StatefulWidget {
  @override
  _AddDeviceScreenState createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen> {
  bool isScanning = false;
  bool isBluetoothOn = false;
  List<BluetoothDevice> scannedDevices = [];

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  @override
  void dispose() {
    FlutterBluePlus.stopScan();
    super.dispose();
  }

  /// Request Bluetooth & Location permissions
  Future<void> _requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.location,
    ].request();

    if (mounted &&
        statuses[Permission.bluetoothScan]!.isGranted &&
        statuses[Permission.bluetoothConnect]!.isGranted &&
        statuses[Permission.location]!.isGranted) {
      _checkBluetoothStatus();
    }
  }

  /// Check Bluetooth status and start scanning automatically
  Future<void> _checkBluetoothStatus() async {
    bool bluetoothStatus = await FlutterBluePlus.isOn;
    if (mounted) {
      setState(() {
        isBluetoothOn = bluetoothStatus;
      });
    }
    if (isBluetoothOn) {
      _startScanning(); // Start scanning automatically
    }
  }

  /// Start scanning for devices
  void _startScanning() {
    if (!isBluetoothOn) {
      _showBluetoothDialog();
      return;
    }

    if (mounted) {
      setState(() {
        isScanning = true;
        scannedDevices.clear();
      });
    }

    FlutterBluePlus.startScan(timeout: Duration(seconds: 5));

    FlutterBluePlus.scanResults.listen((results) {
      if (!mounted) return;
      for (ScanResult result in results) {
        if (!scannedDevices.contains(result.device)) {
          if (mounted) {
            setState(() {
              scannedDevices.add(result.device);
            });
          }
        }
      }
    });

    Future.delayed(Duration(seconds: 5), () {
      FlutterBluePlus.stopScan();
      if (mounted) {
        setState(() => isScanning = false);
      }
    });
  }

  /// Show a dialog asking the user to enable Bluetooth
  void _showBluetoothDialog() {
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Turn on Bluetooth"),
        content: Text("Bluetooth is required to discover nearby devices."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              FlutterBluePlus.turnOn();
              Navigator.pop(context);
              _checkBluetoothStatus();
            },
            child: Text("Enable"),
          ),
        ],
      ),
    );
  }

  /// Add a selected device
  void _addDevice(BluetoothDevice device) {
    if (!mounted) return;
    Navigator.pop(
        context, device.name.isNotEmpty ? device.name : "Unknown Device");
  }

  /// UI for scanning animation with GIF
  Widget _buildScanningAnimation() {
    return Column(
      children: [
        SizedBox(height: 20),
        if (isScanning)
          Column(
            children: [
              SizedBox(
                height: 150,
                width: 150,
                //child: Image.asset(
                //"assets/animations/radar.gif", // Add scanning GIF
                //fit: BoxFit.cover,
                //),
              ),
              SizedBox(height: 10),
              Text(
                "Scanning for nearby devices...",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          )
        else
          ElevatedButton(
            onPressed: _startScanning,
            child: Text("Scan Again"),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Device'),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {
              // Implement QR Code scanning logic
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bluetooth Permission UI
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey[200],
            child: Row(
              children: [
                Icon(Icons.bluetooth,
                    color: isBluetoothOn ? Colors.blue : Colors.red),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    isBluetoothOn
                        ? "Bluetooth is enabled"
                        : "Turn on Bluetooth to discover devices.",
                  ),
                ),
                if (!isBluetoothOn)
                  ElevatedButton(
                    onPressed: _showBluetoothDialog,
                    child: Text("Enable"),
                  ),
              ],
            ),
          ),

          // Scanning Animation
          _buildScanningAnimation(),

          // List of Discovered Devices
          Expanded(
            child: ListView.builder(
              itemCount: scannedDevices.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(scannedDevices[index].name.isNotEmpty
                      ? scannedDevices[index].name
                      : "Unknown Device"),
                  subtitle: Text(scannedDevices[index].id.toString()),
                  trailing: Icon(Icons.add),
                  onTap: () => _addDevice(scannedDevices[index]),
                );
              },
            ),
          ),

          // Add Manually Section
          Padding(
            padding: EdgeInsets.all(16),
            child: Text("Add Manually",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildManualDeviceTile(
                  "Plug (BLE+Wi-Fi)", Icons.electrical_services),
              _buildManualDeviceTile("Socket (Wi-Fi)", Icons.power),
              _buildManualDeviceTile("Socket (Zigbee)", Icons.power_off),
            ],
          ),
        ],
      ),
    );
  }

  /// UI for adding devices manually
  Widget _buildManualDeviceTile(String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 40),
        SizedBox(height: 5),
        Text(label, textAlign: TextAlign.center),
      ],
    );
  }
}
