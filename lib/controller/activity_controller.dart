import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:streamline/model/activity.dart';

import '../constants/firebase_constants.dart';

class ActivitiesController extends GetxController {
  RxList<ActivityModel> activities = RxList([]);
  //var activities = <ActivityModel>[].obs;
  final String _uid = authController.user.uid;
  final _firestore = FirebaseFirestore.instance;
  String get uid {
    return _uid;
  }

  @override
  void onInit() {
    super.onInit();

    activities.bindStream(activityStream(_uid));
  }

  Stream<List<ActivityModel>> activityStream(String uid) {
    return _firestore
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

  Future<void> addActivity({
    required content,
    required timeGoal,
  }) async {
    try {
      await _firestore
          .collection("users")
          .doc(_uid)
          .collection("activities")
          .add({
        'content': content,
        'timegoal': timeGoal,
        'started': false,
        'iscompleted': false,
        'timeadded': Timestamp.now(),
      });
      Get.back();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> updateActivity({
    required String content,
    required String uid,
    required String actvId,
    required int timeGoal,
  }) async {
    try {
      _firestore
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
}
