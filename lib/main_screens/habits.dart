import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:streamline/main_screens/progress.dart';
import 'package:streamline/main_screens/settings.dart';

import 'home.dart';

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({super.key});

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Habits')),
    );
  }
}
