import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HabitModel {
  String habitName;
  String? description;
  final Timestamp timeAdded;
  final Timestamp? timeCompleted;
  int repeatDaily = 1;
  IconData icon;
  bool isCompleted = false;
  int completedCount = 0;

  HabitModel({
    required this.habitName,
    this.description,
    required this.timeAdded,
    this.timeCompleted,
    required this.repeatDaily,
    required this.isCompleted,
    required this.icon,
    required this.completedCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'habitname': habitName,
      'description': description,
      'timeadded': timeAdded,
      'timecompleted': timeCompleted,
      'repeatdaily': repeatDaily,
      'icon': icon,
      'iscompleted': isCompleted,
    };
  }

  HabitModel.fromMap(Map<String, dynamic> habitsList)
      : habitName = habitsList['habitname'],
        description = habitsList['description'],
        timeAdded = habitsList['timeadded'],
        timeCompleted = habitsList['timecompleted'],
        repeatDaily = habitsList['repeatdaily'],
        icon =  IconData(habitsList['icon'], fontFamily: 'MaterialIcons'),
        isCompleted = habitsList['iscompleted'];
}
