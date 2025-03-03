import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';

Future<void> storeDeviceToken(String token) async {
  final deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  String deviceId = androidInfo.id; // Unique Device ID

  String url = "https://trading.rscapitalgrowth.in/device_token_insert.php";

  var response = await http.post(
    Uri.parse(url),
    body: {
      "device_id": deviceId, // Unique device ID
      "device_token": token // Push notification token
    },
  );

  if (response.statusCode == 200) {
    print("Device token stored successfully!");
  } else {
    print("Failed to store device token.");
  }
}
