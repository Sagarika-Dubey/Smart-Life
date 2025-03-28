import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import './login_signin/first_page.dart';
import './services/storing_the_token.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../services/notification.dart';
import 'dart:async';

/// Background Message Handler (MUST be a top-level function)
Future<void> backgroundHandler(RemoteMessage message) async {
  print("📩 Background Message: ${message.notification?.title}");
}

/// Get FCM Token
Future<String?> getFCMToken() async {
  try {
    String? token = await FirebaseMessaging.instance.getToken();
    print("🔹 FCM Token: $token"); // Debugging
    return token;
  } catch (e) {
    print("⚠️ Failed to get FCM token: $e");
    return null;
  }
}

/// Get Device ID
Future<String?> getDeviceId() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  try {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print("📱 Android Device ID: ${androidInfo.id}"); // Debugging
      return androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print("🍏 iOS Device ID: ${iosInfo.identifierForVendor}"); // Debugging
      return iosInfo.identifierForVendor;
    }
  } catch (e) {
    print("⚠️ Error retrieving device ID: $e");
  }
  return null;
}

/// Send Data to API
Future<void> sendDeviceInfoToAPI() async {
  print("📤 Preparing to send device info to API..."); // Debugging

  String? deviceId = await getDeviceId();
  String? fcmToken = await getFCMToken();

  if (deviceId != null && fcmToken != null) {
    var url = Uri.parse(
        "https://trading.rscapitalgrowth.in/device_token_insert.php"); // 🔹 Replace with your API URL

    var bodyData = jsonEncode({
      "device_id": deviceId,
      "fcm_token": fcmToken,
    });

    print("🔍 API Request Body: $bodyData"); // Debugging

    try {
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: bodyData,
      );

      print("📨 Sending request to API..."); // Debugging

      if (response.statusCode == 200) {
        print("✅ Device Info Sent Successfully! Response: ${response.body}");
      } else {
        print("❌ Failed to send device info. Status: ${response.statusCode}");
        print("⚠️ Response: ${response.body}");
      }
    } catch (e) {
      print("⚠️ API Request Error: $e");
    }
  } else {
    print("⚠️ Failed to retrieve Device ID or FCM Token");
  }
}

FirebaseMessaging messaging = FirebaseMessaging.instance;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void setupFirebaseMessaging() async {
  // Request permissions
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else {
    print('User denied permission');
  }

  // Initialize local notifications
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Foreground message handler
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("Message received: ${message.notification?.title}");

    // Show notification
    showNotification(message.notification?.title ?? "No Title",
        message.notification?.body ?? "No Body");
  });

  // Handle background messages
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("Notification clicked: ${message.notification?.title}");
  });
}

// Function to show notification
Future<void> showNotification(String title, String body) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('channel_id', 'channel_name',
          importance: Importance.max, priority: Priority.high, showWhen: false);
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    title,
    body,
    platformChannelSpecifics,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // ✅ Initialize Firebase

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("📩 New Notification: ${message.notification?.title}");
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("📌 Notification Clicked!");
  });

  sendDeviceInfoToAPI(); // Call the function on app start
  final NotificationService notificationService = NotificationService();
  await notificationService.setupFirebaseMessaging();

  //Timer.periodic(Duration(seconds: 30), (timer) {
  //notificationService.fetchNotifications();
  //});

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Xpertz',
      home: FirstPage(),
    );
  }
}
