import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:gif/gif.dart';
import 'package:smartlife/add_device_manually/Lighting.dart';
import 'package:smartlife/add_device_manually/camera.dart';
import 'package:smartlife/add_device_manually/electrical.dart';
import 'package:smartlife/add_device_manually/energy.dart';
import 'package:smartlife/add_device_manually/entertainment.dart';
import 'package:smartlife/add_device_manually/exercise.dart';
import 'package:smartlife/add_device_manually/kitchen.dart';
import 'package:smartlife/add_device_manually/large_home.dart';
import 'package:smartlife/add_device_manually/outdoore.dart';
import 'package:smartlife/add_device_manually/small_home.dart';

class AddDeviceScreen extends StatefulWidget {
  const AddDeviceScreen({super.key});

  @override
  _AddDeviceScreenState createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen>
    with TickerProviderStateMixin {
  bool isScanning = false;
  bool isBluetoothOn = false;
  List<BluetoothDevice> scannedDevices = [];
  late GifController _controller;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
    _controller = GifController(vsync: this);
    // Start the GIF animation immediately
    _controller.repeat(
        min: 0, max: 1.0, period: const Duration(milliseconds: 1000));
  }

  @override
  void dispose() {
    FlutterBluePlus.stopScan();
    _controller.dispose();
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

    // Ensure the GIF animation is running
    _controller.repeat(
        min: 0, max: 1.0, period: const Duration(milliseconds: 1000));

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
      // Keep the animation running even after scanning stops
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 120,
            width: 120,
            child: Center(
              child: Gif(
                image: AssetImage("assets/animation/radar.gif"),
                controller: _controller,
                fps: 30,
                autostart: Autostart.loop,
                placeholder: (context) =>
                    Center(child: CircularProgressIndicator()),
                onFetchCompleted: () {
                  // Ensure animation starts when GIF is loaded
                  _controller.repeat(
                      min: 0,
                      max: 1.0,
                      period: const Duration(milliseconds: 1000));
                },
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            isScanning ? "Scanning for nearby devices..." : "Ready to scan",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8),
          if (!isScanning)
            ElevatedButton(
              onPressed: _startScanning,
              child: Text("Scan Again"),
            ),
        ],
      ),
    );
  }

  /// Navigate to category page
  void _navigateToCategoryPage(String category) {
    // Close the bottom sheet
    Navigator.pop(context);

    // Navigate to the category-specific page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddDevicePage(),
      ),
    );
  }

  /// Show the device categories popup
  void _showDeviceCategoriesPopup() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            padding: EdgeInsets.only(top: 16),
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Add Device Manually",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddDevicePage()));
                        },
                        child: _buildCategoryTile(
                            "Electrical", Icons.electrical_services),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Lighting()));
                        },
                        child: _buildCategoryTile(
                          "Lighting",
                          Icons.lightbulb_outline,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => largeHomePage()));
                        },
                        child: _buildCategoryTile(
                          "Large Home Appliances",
                          Icons.kitchen,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SmallHome()));
                        },
                        child: _buildCategoryTile(
                          "Small Home Appliances",
                          Icons.home,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Kitchen()));
                        },
                        child: _buildCategoryTile(
                          "Kitchen Appliances",
                          Icons.blender,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Exercise()));
                        },
                        child: _buildCategoryTile(
                          "Exercise & Health",
                          Icons.health_and_safety,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => cameraPage()));
                        },
                        child: _buildCategoryTile(
                          "Camera & Lock",
                          Icons.camera,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OutdoorPage()));
                        },
                        child: _buildCategoryTile(
                          "Outdoor Travel",
                          Icons.directions_bike,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EnergyPage()));
                        },
                        child: _buildCategoryTile(
                          "Energy",
                          Icons.bolt,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Entertainment()));
                        },
                        child: _buildCategoryTile(
                          "Entertainment",
                          Icons.tv,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Build a category tile without sublists
  Widget _buildCategoryTile(String title, IconData icon) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      elevation: .5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor, size: 28),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        trailing: TextButton(
          onPressed: () => _navigateToCategoryPage(title),
          child: Text(
            "View All",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        onTap: () => _navigateToCategoryPage(title),
      ),
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

          // Divider and header for scanned devices
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "Discovered Devices",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(child: Divider()),
              ],
            ),
          ),

          // List of Discovered Devices with dedicated space
          Expanded(
            flex: 2, // Give more space to the device list
            child: scannedDevices.isEmpty
                ? Center(
                    child: Text(
                      isScanning
                          ? "Looking for devices..."
                          : "No devices found. Try scanning again.",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    itemCount: scannedDevices.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: ListTile(
                          leading: Icon(Icons.bluetooth_connected),
                          title: Text(
                            scannedDevices[index].name.isNotEmpty
                                ? scannedDevices[index].name
                                : "Unknown Device",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            "ID: ${scannedDevices[index].id.toString().substring(0, 8)}...",
                          ),
                          trailing: Icon(Icons.add_circle_outline),
                          onTap: () => _addDevice(scannedDevices[index]),
                        ),
                      );
                    },
                  ),
          ),

          // Add Manually Button (replaces the grid)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            child: ElevatedButton.icon(
              icon: Icon(Icons.add),
              label: Text("Add Device Manually"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: _showDeviceCategoriesPopup,
            ),
          ),
        ],
      ),
    );
  }
}
