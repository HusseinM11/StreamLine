import 'package:flutter/material.dart';

class Habit {
   String habitName;
  String? description;
  final DateTime timeAdded;
  final DateTime? timeCompleted;
  int repeatDaily = 1;
   IconData icon;
  List<String>? dayList;
  bool isCompleted = false;
  int completedCount = 0;

  Habit({
    required this.habitName,
    this.description,
    required this.timeAdded,
    this.timeCompleted,
    required this.repeatDaily,
    this.dayList,
    required this.isCompleted,
    required this.icon,
    required this.completedCount,
  });
}
