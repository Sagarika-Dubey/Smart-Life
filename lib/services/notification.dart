import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> setupFirebaseMessaging() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("✅ User granted notification permission");

      const AndroidInitializationSettings androidSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      const InitializationSettings initializationSettings =
          InitializationSettings(android: androidSettings);
      await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print("📩 Foreground Message Received: ${message.notification?.title}");
        showNotification(message.notification?.title ?? "No Title",
            message.notification?.body ?? "No Body");
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print("🔔 Notification Clicked: ${message.notification?.title}");
      });

      RemoteMessage? initialMessage =
          await _firebaseMessaging.getInitialMessage();
      if (initialMessage != null) {
        print("📩 Initial Notification: ${initialMessage.notification?.title}");
      }
    } else {
      print("❌ User denied notification permission");
    }
  }

  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics);
  }

  Future<void> fetchNotifications() async {
    final response = await http.get(
        Uri.parse('https://trading.rscapitalgrowth.in/notificationapi.php'));

    if (response.statusCode == 200) {
      List<dynamic> notifications = jsonDecode(response.body);
      print("🔍 API Response: $notifications");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      int lastNotificationId = prefs.getInt('last_notification_id') ?? 0;

      for (var notification in notifications) {
        int notificationId = notification['id'] ?? 0;
        if (notificationId > lastNotificationId) {
          String title = notification['title'] ?? 'No Title';
          String post = notification['post'] ?? 'No Message';
          showNotification(title, post);

          // Update last notification ID
          await prefs.setInt('last_notification_id', notificationId);
        }
      }
    } else {
      print("❌ Failed to fetch notifications");
    }
  }
}
