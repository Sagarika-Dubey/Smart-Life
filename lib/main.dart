import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './login_signin/first_page.dart';
import './services/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Initialize FCM Service
  await FirebaseMessagingService.initialize();

  //String? token = await FirebaseMessaging.instance.getToken();
  //print("🔥 Manual FCM Token: $token"); // Force token fetch

  runApp(const MyApp());
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
