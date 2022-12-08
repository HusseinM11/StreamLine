class ToDo {
  String todoText;
  bool isCompleted;
  final DateTime? timeAdded;
  final DateTime? timeCompleted;
  ToDo({
    required this.todoText, required this.isCompleted, required this.timeAdded , required this.timeCompleted
  });
}
