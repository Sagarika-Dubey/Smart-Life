import 'package:flutter/material.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool deviceAlert = true;
  bool homeAlert = true;
  bool bulletinAlert = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings',
            style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: Column(
        children: [
          _buildNotificationBanner(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildSectionTitle('General'),
                _buildToggleTile(
                    Icons.notifications_active, 'Device Alert', deviceAlert,
                    (value) {
                  setState(() {
                    deviceAlert = value;
                  });
                }),
                _buildNavigationTile(
                    Icons.schedule, 'Do-Not-Disturb Schedule', 'Not set'),
                _buildSectionTitle('Get Notified By'),
                _buildNavigationTile(
                    Icons.notifications, 'System Notification', 'ON'),
                _buildNavigationTile(Icons.phone, 'Phone Call', 'OFF'),
                _buildNavigationTile(Icons.sms, 'SMS Message', 'OFF'),
                _buildSectionTitle('Other Notifications'),
                _buildToggleTile(Icons.home, 'Home Alerts', homeAlert, (value) {
                  setState(() {
                    homeAlert = value;
                  });
                }),
                _buildToggleTile(
                    Icons.article, 'Bulletin Updates', bulletinAlert, (value) {
                  setState(() {
                    bulletinAlert = value;
                  });
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationBanner() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning, color: Colors.blue, size: 28),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'System Notification Disabled\nEnable message notifications to get notified in time.',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ),
          TextButton(
            onPressed: () {
              // Handle enabling notifications
            },
            child: const Text('Enable Now',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleTile(
      IconData icon, String title, bool value, ValueChanged<bool> onChanged) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: SwitchListTile(
        title: Row(
          children: [
            Icon(icon, color: Colors.blueAccent),
            const SizedBox(width: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        value: value,
        onChanged: onChanged,
        activeColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildNavigationTile(IconData icon, String title, String subtitle) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
        trailing:
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {
          // Handle navigation
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey),
      ),
    );
  }
}
