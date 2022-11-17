import 'package:flutter/material.dart';

class AffirmationsScreen extends StatefulWidget {
  const AffirmationsScreen({super.key});

  @override
  State<AffirmationsScreen> createState() => _AffirmationsScreenState();
}

class _AffirmationsScreenState extends State<AffirmationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Image.asset('images/affirmations/flowers.png')
        );
  }
}
