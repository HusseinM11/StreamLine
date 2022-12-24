import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:streamline/controller/all_tasksController.dart';

import '../constants/firebase_constants.dart';
import '../model/todo.dart';

class TodosController extends GetxController {
  //RxList<HabitModel> habits = RxList([]);
  RxList<TodoModel> todos = RxList([]);
  RxList<TodoModel> completedTodos = RxList([]);
  RxList<TodoModel> todosHistory = RxList([]);

  final String _uid = authController.user.uid;
  final _firestore = FirebaseFirestore.instance;
  String get uid => _uid;

  @override
  void onInit() {
    super.onInit();
    todos.bindStream(todosStream(_uid));
    todosHistory.bindStream(todosHistoryStream(_uid));
  }

  Stream<List<TodoModel>> todosStream(String uid) {
    return _firestore
        .collection("users")
        .doc(_uid)
        .collection("todos")
        .orderBy("timeadded", descending: false)
        .snapshots()
        .map((QuerySnapshot query) {
      List<TodoModel> retVal = [];
      query.docs.forEach((element) {
        retVal.add(TodoModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Stream<List<TodoModel>> todosHistoryStream(String uid) {
    return _firestore
        .collection("users")
        .doc(_uid)
        .collection("todoshistory")
        .orderBy("timeadded", descending: false)
        .snapshots()
        .map((QuerySnapshot query) {
      List<TodoModel> retVal = [];
      query.docs.forEach((element) {
        retVal.add(TodoModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Future<void> addTodoToHistory({
    required String content,
    required Timestamp timeAdded,
  }) async {
    try {
      await _firestore
          .collection("users")
          .doc(_uid)
          .collection("todoshistory")
          .add({
        'content': content,
        'iscompleted': true,
        'timeadded': timeAdded,
        'timecompleted': Timestamp.now()
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }
  Future<void> deleteTodoFromHistory(String uid, String todoId) async {
    try {
      _firestore
          .collection("users")
          .doc(uid)
          .collection('todoshistory')
          .doc(todoId)
          .delete();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> addTodo({
    required String content,
  }) async {
    try {
      await _firestore.collection("users").doc(_uid).collection("todos").add({
        'content': content,
        'iscompleted': false,
        'timeadded': Timestamp.now(),
      });
      Get.back();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> deleteTodo(String uid, String todoId) async {
    try {
      _firestore
          .collection("users")
          .doc(uid)
          .collection('todos')
          .doc(todoId)
          .delete();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> completeTodo(String uid, String todoId) async {
    try {
      _firestore
          .collection("users")
          .doc(uid)
          .collection('todos')
          .doc(todoId)
          .update({'iscompleted': true, 'timecompleted': Timestamp.now()});
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> uncompleteTodo(String uid, String todoId) async {
    try {
      _firestore
          .collection("users")
          .doc(uid)
          .collection('todos')
          .doc(todoId)
          .update({'iscompleted': false, 'timecompleted': FieldValue.delete()});
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  int numberOfCompletedTodosToday() {
    int count = 0;
    for (var element in todos) {
      if (element.isCompleted == true &&
          element.timeCompleted?.toDate().day == DateTime.now().day) {
        count++;
      }
    }
    return count;
  }

  int getCompletedTodos(DateTime day) {
    int count = 0;
    for (var element in todos.where((task) => task.isCompleted)) {
      if (element.timeCompleted!.toDate().day == day.day) {
        count++;
      }
    }
    return count;
  }
}
