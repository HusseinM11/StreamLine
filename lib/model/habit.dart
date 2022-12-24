import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:streamline/model/task.dart';

class HabitModel implements Task {
 final String habitId;
  String content;
  String? description;
  final Timestamp timeAdded;
  final Timestamp? timeCompleted;
  int repeatDaily = 1;
  IconData icon;
  bool isCompleted = false;
  int completedCount = 0;

  HabitModel({
    required this.habitId,
    required this.content,
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
      'content': content,
      'description': description,
      'timeadded': timeAdded,
      'timecompleted': timeCompleted,
      'repeatdaily': repeatDaily,
      'icon': icon,
      'iscompleted': isCompleted,
    };
  }

  HabitModel.fromDocumentSnapshot(DocumentSnapshot doc)
      : content = doc['content'],
        habitId = doc.id,
        description = doc.data().toString().contains('description') ? doc['description'] : 'description',
        timeAdded = doc['timeadded'],
        timeCompleted = doc.data().toString().contains('timecompleted') ? doc['timecompleted'] : Timestamp.now(),
        repeatDaily = doc['repeatdaily'],
        icon = doc.data().toString().contains('icon') ? IconData(doc['icon'], fontFamily: 'MaterialIcons') : IconData(63029, fontFamily: 'MaterialIcons'),
        completedCount = doc['completedcount'],
        isCompleted = doc['iscompleted'];
        
          @override
          set timeAdded(Timestamp _timeAdded) {
            
          }
        
          @override
          set timeCompleted(Timestamp? _timeCompleted) {
            
          }
}
