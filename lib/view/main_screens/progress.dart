import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:streamline/view/main_screens/settings.dart';

import 'habits.dart';
import 'home.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Progress')),
    );
  }
}
