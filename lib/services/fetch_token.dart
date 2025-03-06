import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getFCMToken() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? token = await messaging.getToken();
  return token;
}

Future<String?> getDeviceId() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  return androidInfo.id;
}

// Function to store FCM token locally
Future<void> saveTokenLocally(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('last_fcm_token', token);
}

// Function to get last stored FCM token
Future<String?> getLastStoredToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('last_fcm_token');
}

// Function to send FCM token only if it's new
Future<void> sendTokenToAPI(String deviceId, String fcmToken) async {
  String? lastToken = await getLastStoredToken();

  if (lastToken == fcmToken) {
    print('Token is unchanged, skipping API call.');
    return; // Do not send duplicate tokens
  }

  try {
    final response = await http.post(
      Uri.parse('https://trading.rscapitalgrowth.in/device_token_insert.php'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'device_id': deviceId, 'fcm_token': fcmToken}),
    );

    if (response.statusCode == 201) {
      print('Token inserted successfully');
      await saveTokenLocally(fcmToken); // Save new token after sending
    } else {
      print('Failed to send token: ${response.statusCode}');
      print('Response: ${response.body}');
    }
  } catch (e) {
    print('Error sending token: $e');
  }
}
