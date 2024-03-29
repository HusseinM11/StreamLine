import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cron/cron.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../constants/firebase_constants.dart';
import '../model/habit.dart';
import '../view/widgets/snackbar.dart';

class HabitsController extends GetxController {
  //var habits = <HabitModel>[].obs;

  RxList<HabitModel> habits = RxList([]);
  RxList<HabitModel> habitsHistory = RxList([]);
 final String _uid = authController.user.uid!;
  //final String _uid = '312123232';
   FirebaseFirestore firestore = FirebaseFirestore.instance;

  //cosnstructor to set firestiore
  HabitsController({required this.firestore});
  @override
  void onInit() {
    super.onInit();
    habits.bindStream(habitStream(_uid));
    habitsHistory.bindStream(habitHistoryStream(_uid));
  }

  String get uid {
    return _uid;
  }

  Future<String> deleteHabit(String uid, String habitId) async {
    try {
      firestore
          .collection("users")
          .doc(uid)
          .collection('habits')
          .doc(habitId)
          .delete();
      return 'success';
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> completeHabit(
      {required String uid,
      required String habitId,
      required int repeat,
      required completedCount,
      required int index}) async {
    try {
      await firestore
          .collection("users")
          .doc(uid)
          .collection('habits')
          .doc(habitId)
          .update(
              {'iscompleted': true, 'completedcount': FieldValue.increment(1)});
      if (repeat - completedCount == 1) {
        DateTime lastCompletedDate = habits[index].timeCompleted!.toDate();
        await firestore
            .collection("users")
            .doc(uid)
            .collection('habits')
            .doc(habitId)
            .update({
          'timecompleted': Timestamp.now(),
        });
        DateTime currentDate = DateTime.now();

        if (lastCompletedDate != null &&
            currentDate.difference(lastCompletedDate).inDays == 1) {
          await firestore
              .collection("users")
              .doc(uid)
              .collection('habits')
              .doc(habitId)
              .update({'streak': FieldValue.increment(1)});
        } else {
          await firestore
              .collection("users")
              .doc(uid)
              .collection('habits')
              .doc(habitId)
              .update({'streak': 1});
        }
        lastCompletedDate = currentDate;
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> updateHabit(
      {required String content,
      required String? description,
      required int repeat,
      required IconData icon,
      required String uid,
      required String habitId,
      required int completedCount,
      required String priority}) async {
    try {
      firestore
          .collection("users")
          .doc(uid)
          .collection("habits")
          .doc(habitId)
          .update({
        'content': content,
        'description': description,
        'repeatdaily': repeat,
        'icon': icon.codePoint,
        'completedcount': completedCount,
        'priority': priority,
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> increaseCount(
      {required String uid,
      required String habitId,
      required int completedCount}) async {
    try {
      firestore
          .collection("users")
          .doc(uid)
          .collection("habits")
          .doc(habitId)
          .update({'completedcount': FieldValue.increment(1)});
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Stream<List<HabitModel>> habitStream(String uid) {
    return firestore
        .collection("users")
        .doc(_uid)
        .collection("habits")
        .snapshots()
        .map((QuerySnapshot query) {
      List<HabitModel> retVal = [];
      query.docs.forEach((element) {
        retVal.add(HabitModel.fromDocumentSnapshot(element));
      });
      retVal.sort((a, b) {
        if (a.priority == b.priority) {
          return 0;
        }
        if (a.priority == 'High') {
          return -1;
        } else if (a.priority == 'Medium') {
          if (b.priority == 'High') {
            return 1;
          } else {
            return -1;
          }
        } else {
          return 1;
        }
      });
      return retVal;
    });
  }

  Future<String> addHabit(
      {required String content,
      required String? description,
      required int repeat,
      required bool isCompleted,
      required IconData icon,
      required int completedCount,
      required Timestamp timeAdded,
      required String priority}) async {
    try {
      await firestore.collection("users").doc(_uid).collection("habits").add({
        'content': content,
        'description': description,
        'repeatdaily': repeat,
        'iscompleted': isCompleted,
        'icon': icon.codePoint,
        'completedcount': completedCount,
        'timeadded': timeAdded,
        'priority': priority,
      });
      return 'success'; 
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<String> addHabitToHistory(
      {required String content,
      required int repeat,
      required Timestamp timeAdded}) async {
    try {
      await firestore
          .collection("users")
          .doc(_uid)
          .collection("habitshistory")
          .add({
        'content': content,
        'repeatdaily': repeat,
        'iscompleted': true,
        'completedcount': repeat,
        'timeadded': timeAdded,
        'timecompleted': Timestamp.now()
      });
      return 'success';
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Stream<List<HabitModel>> habitHistoryStream(String uid) {
    return firestore
        .collection("users")
        .doc(_uid)
        .collection("habitshistory")
        .orderBy("timeadded", descending: false)
        .snapshots()
        .map((QuerySnapshot query) {
      // List<HabitModel> retVal = [];

      List<HabitModel> retVal = [];
      query.docs.forEach((element) {
        retVal.add(HabitModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Future<void> resetHabits() async {
    try {
      await firestore.collection("users").get().then((QuerySnapshot query) {
        query.docs.forEach((doc) {
          firestore
              .collection("users")
              .doc(doc.id)
              .collection("habits")
              .get()
              .then((QuerySnapshot query) {
            query.docs.forEach((habitDoc) {
              firestore
                  .collection('users')
                  .doc(doc.id)
                  .collection('habits')
                  .doc(habitDoc.id)
                  .update({'iscompleted': false, 'completedcount': 0});
            });
          });
        });
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  int numberOfCompletedHabitsToday() {
    int count = 0;
    for (var element in habitsHistory) {
      if (element.timeCompleted!.toDate().day ==  DateTime.now().day) {
        count++;
      }
    }
    return count;
  }

  int getCompletedHabits(DateTime day) {
    int count = 0;
    for (var element in habits.where((task) => task.isCompleted)) {
      if (element.timeCompleted!.toDate().day == day.day) {
        count++;
      }
    }
    return count;
  }

 
  int totalHabitsToday() {
  int count = 0;
  for (var element in habits) {
    if (element.timeAdded.toDate().day == DateTime.now().day) {
      count++;
    }
  }

  for (var element in habitsHistory) {
    if (element.timeCompleted!.toDate().day == DateTime.now().day) {
      //check if the todo is in the todos list
      if (habits.where((habit) => habit.content == element.content).isEmpty) {
        count++;
      }
    }
  }
  return count;
}
}
