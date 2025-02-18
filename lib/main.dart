import 'package:flutter/material.dart';
import './login_signin/first_page.dart';
import './login_signin/login.dart';
import './login_signin/sigin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Life',
      home: FirstPage(),
    );
  }
}
