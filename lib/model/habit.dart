import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HabitModel {
 final String habitId;
  String habitName;
  String? description;
  final Timestamp timeAdded;
  final Timestamp? timeCompleted;
  int repeatDaily = 1;
  IconData icon;
  bool isCompleted = false;
  int completedCount = 0;

  HabitModel({
    required this.habitId,
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

  HabitModel.fromDocumentSnapshot(DocumentSnapshot doc)
      : habitName = doc['habitname'],
        habitId = doc.id,
        description = doc['description'],
        timeAdded = doc['timeadded'],
        timeCompleted = doc.data().toString().contains('timecompleted') ? doc['timecompleted'] : Timestamp.now(),
        repeatDaily = doc['repeatdaily'],
        icon = IconData(doc['icon'], fontFamily: 'MaterialIcons'),
        completedCount = doc['completedcount'],
        isCompleted = doc['iscompleted'];
}
