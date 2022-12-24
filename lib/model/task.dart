import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Task {
  String content;
  bool isCompleted;
  Timestamp timeAdded;
  Timestamp? timeCompleted;

  Task({
    required this.content,
    required this.isCompleted,
    required this.timeAdded,
    this.timeCompleted,
  });
  
}
