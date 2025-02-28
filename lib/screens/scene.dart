import 'package:flutter/material.dart';
import 'package:smartlife/screens/automation.dart';
import './automation.dart';

class SceneScreen extends StatelessWidget {
  const SceneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AutomationSceneScreen(),
    );
  }
}
