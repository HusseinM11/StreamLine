import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:streamline/model/activity.dart';

import '../constants/firebase_constants.dart';

class ActivitiesController extends GetxController {
  RxList<ActivityModel> activities = RxList([]);
  RxList<ActivityModel> activitiesHistory = RxList([]);
  //var activities = <ActivityModel>[].obs;
  final String _uid = "312123232";
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //constructor to initialize the firestore
  ActivitiesController({required this.firestore});

  String get uid {
    return _uid;
  }

  @override
  void onInit() {
    super.onInit();

    activities.bindStream(activityStream(_uid));
    activitiesHistory.bindStream(activitiesHistoryStream(_uid));
  }

  Stream<List<ActivityModel>> activityStream(String uid) {
    return firestore
        .collection("users")
        .doc(_uid)
        .collection("activities")
        .orderBy("timeadded", descending: false)
        .snapshots()
        .map((QuerySnapshot query) {
      // List<HabitModel> retVal = [];

      List<ActivityModel> retVal = [];
      query.docs.forEach((element) {
        retVal.add(ActivityModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Stream<List<ActivityModel>> activitiesHistoryStream(String uid) {
    return firestore
        .collection("users")
        .doc(_uid)
        .collection("activitieshistory")
        .orderBy("timeadded", descending: false)
        .snapshots()
        .map((QuerySnapshot query) {
      List<ActivityModel> retVal = [];
      query.docs.forEach((element) {
        retVal.add(ActivityModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Future<void> addActivityToHistory({
    required String content,
    required Timestamp timeAdded,
  }) async {
    try {
      await firestore
          .collection("users")
          .doc(_uid)
          .collection("activitieshistory")
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

  Future<String> addActivity({
    required content,
    required timeGoal,
  }) async {
    try {
      await firestore
          .collection("users")
          .doc(_uid)
          .collection("activities")
          .add({
        'content': content,
        'timegoal': timeGoal,
        'started': false,
        'iscompleted': false,
        'timeadded': Timestamp.now(),
        'timespent': 0,
      });
      return "success";
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<void> updateActivity({
    required String content,
    required String uid,
    required String actvId,
    required int timeGoal,
  }) async {
    try {
      firestore
          .collection("users")
          .doc(uid)
          .collection("activities")
          .doc(actvId)
          .update({
        'content': content,
        'timegoal': timeGoal,
      });
      Get.back();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> saveActivity(
      {required String uid,
      required String actvId,
      required int timeSpent,
      required started,
      required isCompleted,
      timeCompleted}) async {
    try {
      firestore
          .collection("users")
          .doc(uid)
          .collection("activities")
          .doc(actvId)
          .update({
        'started': true,
        'timespent': timeSpent,
        'started': started,
        'iscompleted': isCompleted,
        'timecompleted': timeCompleted
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<String> restartActivity({
    required String uid,
    required String actvId,
  }) async {
    try {
      firestore
          .collection("users")
          .doc(uid)
          .collection("activities")
          .doc(actvId)
          .update({
        'started': false,
        'timespent': 0,
        'iscompleted': false,
      });
      return 'success';
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<String> deleteActivity(
      {required String uid, required String actvId}) async {
    try {
      firestore
          .collection("users")
          .doc(uid)
          .collection('activities')
          .doc(actvId)
          .delete();
      Get.back();
      return "success";
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  int numberOfCompletedActivitiesToday() {
    int count = 0;
    for (var element in activitiesHistory) {
      if (element.timeCompleted!.toDate().day == DateTime.now().day) {
        count++;
      }
    }
    return count;
  }

  int getCompletedActivities(DateTime day) {
    int count = 0;
    for (var element in activities.where((task) => task.isCompleted)) {
      if (element.timeCompleted!.toDate().day == day.day) {
        count++;
      }
    }
    return count;
  }

  int totalActivitiesToday() {
    int count = 0;
    for (var element in activities) {
      if (element.timeAdded.toDate().day == DateTime.now().day) {
        count++;
      }
    }

    for (var element in activitiesHistory) {
      if (element.timeCompleted!.toDate().day == DateTime.now().day) {
        //check if the todo is in the todos list
        if (activities
            .where((activity) => activity.content == element.content)
            .isEmpty) {
          count++;
        }
      }
    }
    return count;
  }
}
