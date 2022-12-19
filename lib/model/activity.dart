import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityModel {
  final String actvId;
  String content;
  int timeGoal;
  int timeSpent = 0;
  bool started;
  bool isCompleted;
  Timestamp timeAdded;

  ActivityModel(
      {required this.actvId,
      required this.content,
      required this.timeGoal,
      required this.started,
      required this.timeAdded,
      required this.isCompleted});

  ActivityModel.fromDocumentSnapshot(DocumentSnapshot doc)
      : content = doc['content'],
        timeAdded = doc['timeadded'],
        actvId = doc.id,
        timeGoal = doc['timegoal'],
        timeSpent = doc.data().toString().contains('timespent')
            ? doc['timespent']
            : 0,
        started = doc['started'],
        isCompleted = doc['iscompleted'];
}
