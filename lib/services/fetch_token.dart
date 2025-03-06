import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

Future<void> sendTokenToAPI(String deviceId, String fcmToken) async {
  try {
    final response = await http.post(
      Uri.parse('https://trading.rscapitalgrowth.in/device_token_insert.php'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'device_id': deviceId, 'fcm_token': fcmToken}),
    );

    if (response.statusCode == 201) {
      print('Token inserted successfully');
    } else {
      print('Failed to send token: ${response.statusCode}');
      print('Response: ${response.body}');
    }
  } catch (e) {
    print('Error sending token: $e');
  }
}
