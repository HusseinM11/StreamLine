import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../model/habit.dart';
import '../widgets/snackbar.dart';

class HabitsController extends GetxController {
  //var habits = <HabitModel>[].obs;
  RxList<HabitModel> habits = RxList([]);
  final String _uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  void onInit() {
    super.onInit();
    habits.bindStream(habitStream(_uid));
  }

  /* void fetchHabits() async {
    await Future.delayed(Duration(seconds: 1));
    var habitsResult = [
      Habit(
          habitName: 'Read',
          repeatDaily: 2,
          isCompleted: false,
          icon: FeatherIcons.book,
          completedCount: 0,
          timeAdded: DateTime.now()),
      Habit(
          habitName: 'Workout',
          repeatDaily: 1,
          isCompleted: false,
          icon: FeatherIcons.book,
          completedCount: 0,
          timeAdded: DateTime.now()),
      Habit(
          habitName: 'Drink water',
          repeatDaily: 3,
          isCompleted: false,
          icon: FeatherIcons.book,
          completedCount: 0,
          timeAdded: DateTime.now()),
      Habit(
          habitName: 'Take creatine',
          repeatDaily: 1,
          isCompleted: false,
          icon: FeatherIcons.book,
          completedCount: 0,
          timeAdded: DateTime.now()),
    ];
    habits.assignAll(habitsResult);
  } */
  /* Future<void> fetchHabits() async {
    try {
      QuerySnapshot habitsList = await FirebaseFirestore.instance
          .collection('users')
          .doc(_uid)
          .collection('habits')
          .get();

      habits.clear();
      for (var habit in habitsList.docs) {
        habits.add(
          HabitModel(
            habitName: habit['habitname'],
            repeatDaily: habit['repeatdaily'],
            isCompleted: habit['iscompleted'],
            icon: IconData(habit['icon'], fontFamily: 'CupertinoIcons'),
            completedCount: habit['completedcount'],
            timeAdded: habit['timeadded'],
          ),
        );
        debugPrint('added');
        update();
      }
    } catch (e) {
      Get.snackbar('Error', '${e.toString()}');
    }
  } */

  void completeHabit(int index, _scaffoldKey) {
    if (habits[index].completedCount == habits[index].repeatDaily) {
      MyMessageHandler.showSnackBar(
          _scaffoldKey, 'Habit is already completed for the day.');
    } else {
      habits[index].isCompleted = true;
      habits[index].completedCount++;
      update();
    }
  }

  void deleteHabit(int index) {
    habits.removeAt(index);
    update();
  }

  void setRepeat(int index, int repeatDaily) {
    habits[index].repeatDaily = repeatDaily;
    update();
  }

  Stream<List<HabitModel>> habitStream(String uid) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(_uid)
        .collection("habits")
        .orderBy("timeadded", descending: false)
        .snapshots()
        .map((QuerySnapshot query) {
      // List<HabitModel> retVal = [];

      List<HabitModel> retVal = [];
      query.docs.forEach((element) {
        retVal.add(HabitModel.fromMap(element.data() as Map<String, dynamic>));
      });
      return retVal;
    });
  }

  Future<void> addHabit(
      {required String habitName,
      required String? description,
      required int repeat,
      required bool isCompleted,
      required IconData icon,
      required int completedCount,
      required Timestamp timeAdded}) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_uid)
          .collection("habits")
          .add({
        'habitname': habitName,
        'description': description,
        'repeatdaily': repeat,
        'iscompleted': isCompleted,
        'icon': icon.codePoint,
        'completedcount': completedCount,
        'timeadded': timeAdded
      });
      Get.back();
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
