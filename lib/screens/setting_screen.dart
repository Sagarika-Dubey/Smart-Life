import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartlife/login_signin/login.dart';
import 'package:smartlife/screens/settings_pages/about_page.dart';
import 'package:smartlife/screens/settings_pages/acc_security.dart';
import 'package:smartlife/screens/settings_pages/app_notification.dart';
import 'package:smartlife/screens/settings_pages/more_features.dart';
import 'package:smartlife/screens/settings_pages/network_diagnosis.dart';
import 'package:smartlife/screens/settings_pages/privacy_policy.dart';
import 'package:smartlife/screens/terms_and_conditions/privacy_policy.dart';
import './profile_page.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isTouchToneEnabled = false;
  bool isDarkMode = false;
  String temperatureUnit = "°C";
  String language = "Same as system language";
  double cacheSize = 4.12; // Example cache size in MB

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  /// Load saved user settings
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isTouchToneEnabled = prefs.getBool('touchTone') ?? false;
      isDarkMode = prefs.getBool('darkMode') ?? false;
      temperatureUnit = prefs.getString('temperatureUnit') ?? "°C";
      language = prefs.getString('language') ?? "Same as system language";
    });
  }

  /// Save settings when changed
  Future<void> _savePreference(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    }
  }

  /// Simulate clearing app cache
  void _clearCache() {
    setState(() {
      cacheSize = 0.0;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Cache Cleared!")),
    );
  }

  /// Handle logout action
  void _logout() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Logged Out! Redirecting to login...")),
    );

    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Login()),
        (Route<dynamic> route) => false, // Clears all previous routes
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          _settingsTile(
            "Personal Information",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            ),
          ),
          _settingsTile("Account and Security",
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AccountSecurityScreen()))),
          _settingsTile("Device Update"),
          Divider(),
          _toggleTile(
            "Touch Tone on Panel",
            isTouchToneEnabled,
            (value) {
              setState(() => isTouchToneEnabled = value);
              _savePreference('touchTone', value);
            },
          ),
          _settingsTile("App Notification",
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationSettingsScreen()))),
          _toggleTile(
            "Dark Mode",
            isDarkMode,
            (value) {
              setState(() => isDarkMode = value);
              _savePreference('darkMode', value);
            },
          ),
          _dropdownTile(
            "Temperature Unit",
            temperatureUnit,
            ["°C", "°F"],
            (newValue) {
              setState(() => temperatureUnit = newValue);
              _savePreference('temperatureUnit', newValue);
            },
          ),
          _dropdownTile(
            "Language",
            language,
            ["Same as system language", "English", "Spanish", "French"],
            (newValue) {
              setState(() => language = newValue);
              _savePreference('language', newValue);
            },
          ),
          _settingsTile("More Features",
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MoreFeaturesScreen()))),
          Divider(),
          _settingsTile("Settings of Smart Control (New)", isNew: true),
          _settingsTile("About",
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AboutPage()))),
          _settingsTile(
            "Privacy Settings",
          ),
          _settingsTile("Privacy Policy Management",
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PrivacyPolicyPage()))),
          _settingsTile("Network Diagnosis",
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NetworkDiagnosisApp()))),
          _settingsTile("Clear Cache",
              subtitle: "${cacheSize.toStringAsFixed(2)}M", onTap: _clearCache),
          SizedBox(height: 20),
          Center(
            child: TextButton(
              onPressed: _logout,
              child: Text("Log Out",
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  /// **Reusable Widget for Normal Settings Tiles**
  Widget _settingsTile(String title,
      {String? subtitle, bool isNew = false, VoidCallback? onTap}) {
    return ListTile(
      title: Text(title, style: TextStyle(fontSize: 16)),
      subtitle: subtitle != null
          ? Text(subtitle, style: TextStyle(color: Colors.grey[600]))
          : null,
      trailing: isNew
          ? Icon(Icons.circle, color: Colors.red, size: 10)
          : Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  /// **Reusable Toggle Switch Tile**
  Widget _toggleTile(String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }

  /// **Dropdown Setting with Selection**
  Widget _dropdownTile(String title, String currentValue, List<String> options,
      Function(String) onChanged) {
    return ListTile(
      title: Text(title),
      trailing: DropdownButton<String>(
        value: currentValue,
        onChanged: (String? newValue) {
          if (newValue != null) {
            onChanged(newValue);
          }
        },
        items: options.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList(),
      ),
    );
  }
}
