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
import '../widgets/snackbar.dart';

class HabitsController extends GetxController {
  //var habits = <HabitModel>[].obs;

  RxList<HabitModel> habits = RxList([]);
  final String _uid = authController.user.uid;
  final _firestore = FirebaseFirestore.instance;
  @override
  void onInit() {
    super.onInit();
    habits.bindStream(habitStream(_uid));
  }

  String get uid {
    return _uid;
  }

  Future<void> deleteHabit(String uid, String habitId) async {
    try {
      _firestore
          .collection("users")
          .doc(uid)
          .collection('habits')
          .doc(habitId)
          .delete();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> completeHabit(
      {required String uid, required String habitId, required int repeat, required completedCount}) async {
    try {
      
      _firestore
          .collection("users")
          .doc(uid)
          .collection('habits')
          .doc(habitId)
          .update({
        'iscompleted': true,
        'completedcount': FieldValue.increment(1)
      });
      if(repeat - completedCount == 1) {
        _firestore
          .collection("users")
          .doc(uid)
          .collection('habits')
          .doc(habitId)
          .update({
        'timecompleted' : Timestamp.now(),
      });
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> updateHabit({
    required String habitName,
    required String? description,
    required int repeat,
    required IconData icon,
    required String uid,
    required String habitId,
  }) async {
    try {
      _firestore
          .collection("users")
          .doc(uid)
          .collection("habits")
          .doc(habitId)
          .update({
        'habitname': habitName,
        'description': description,
        'repeatdaily': repeat,
        'icon': icon.codePoint,
      });
      Get.back();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Stream<List<HabitModel>> habitStream(String uid) {
    return _firestore
        .collection("users")
        .doc(_uid)
        .collection("habits")
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

  Future<void> addHabit(
      {required String habitName,
      required String? description,
      required int repeat,
      required bool isCompleted,
      required IconData icon,
      required int completedCount,
      required Timestamp timeAdded}) async {
    try {
      await _firestore.collection("users").doc(_uid).collection("habits").add({
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

  Future<void> resetHabits() async {
    try {
      
      await _firestore.collection("users").get().then((QuerySnapshot query) {
        query.docs.forEach((doc) {
          _firestore
              .collection("users")
              .doc(doc.id)
              .collection("habits")
              .get()
              .then((QuerySnapshot query) {
            query.docs.forEach((habitDoc) {
              _firestore.collection('users').doc(doc.id)
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
}

// .update({'iscompleted' : false, 'completedcount' : 0});

//00 00 1-31 1-12 *