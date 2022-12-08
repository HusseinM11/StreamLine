import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:streamline/main_screens/home_content.dart';
import 'package:streamline/main_screens/progress.dart';
import 'package:streamline/main_screens/settings.dart';

import 'habits.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  List<Widget> _tabs = [
    HomeContentScreen(documentId: FirebaseAuth.instance.currentUser!.uid),
     HabitsScreen(),
    const ProgressScreen(),
    const SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        unselectedItemColor: const Color(0xFF312B26).withOpacity(0.6),
        selectedItemColor: const Color(0xFFFF6E50),
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(FeatherIcons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(FeatherIcons.checkCircle), label: 'Habits'),
          BottomNavigationBarItem(
              icon: Icon(FeatherIcons.barChart), label: 'Progress'),
          BottomNavigationBarItem(
              icon: Icon(FeatherIcons.settings), label: 'Settings'),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
