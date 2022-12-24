import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:streamline/model/task.dart';

class TodoModel implements Task {
  String content;
  final String todoId;
  bool isCompleted;
  final Timestamp timeAdded;
  final Timestamp? timeCompleted;
  TodoModel(
      {required this.todoId,
      required this.content,
      required this.isCompleted,
      required this.timeAdded,
       this.timeCompleted});

  TodoModel.fromDocumentSnapshot(DocumentSnapshot doc)
      : todoId = doc.id,
        content = doc["content"],
        timeAdded = doc["timeadded"],
        timeCompleted = doc.data().toString().contains('timecompleted') ? doc['timecompleted'] : Timestamp.now(),
        isCompleted = doc["iscompleted"];
        
          @override
          set timeAdded(Timestamp _timeAdded) {
            
          }
        
          @override
          set timeCompleted(Timestamp? _timeCompleted) {
            
          }
}
