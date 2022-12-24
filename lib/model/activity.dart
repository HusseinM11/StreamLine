import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:streamline/model/task.dart';

class ActivityModel implements Task {
  final String actvId;
  String content;
  int timeGoal;
  int timeSpent = 0;
  bool started;
  bool isCompleted;
  Timestamp timeAdded;
  Timestamp? timeCompleted;

  ActivityModel(
      {required this.actvId,
       this.timeCompleted,
      required this.content,
      required this.timeGoal,
      required this.started,
      required this.timeAdded,
      required this.isCompleted});

  ActivityModel.fromDocumentSnapshot(DocumentSnapshot doc)
      : content = doc['content'],
        timeAdded = doc['timeadded'],
        actvId = doc.id,
        timeGoal = doc.data().toString().contains('timegoal') ? doc['timegoal'] : 20 ,
        timeCompleted = doc.data().toString().contains('timecompleted')
            ? doc['timecompleted']
            : Timestamp.now(),
        timeSpent =
            doc.data().toString().contains('timespent') ? doc['timespent'] : 0,
        started = doc.data().toString().contains('started') ? doc['started'] : false,
        isCompleted = doc['iscompleted'];
}
