// import flutter test package

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:streamline/controller/activity_controller.dart';
import 'package:streamline/controller/auth_controller.dart';

import 'mock.dart';

void main() {
  setupCloudFirestoreMocks();
  setUpAll(() async {
    await Firebase.initializeApp();
  });

  final mockAuth = MockFirebaseAuth();

  //test of the add activity method works
  test('add activity', () async {
    final firestore = FakeFirebaseFirestore();
    final activityController = ActivitiesController(firestore: firestore);
    var result =
        await activityController.addActivity(content: 'Gym', timeGoal: 30);

    expect(result, 'success');
  });
  test('delete activity', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    Get.testMode = true;
    final firestore = FakeFirebaseFirestore();
    final activityController = ActivitiesController(firestore: firestore);
    var result =
        await activityController.deleteActivity(actvId: '2', uid: '312123232');

    expect(result, 'success');
  });
  test('restart activity', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    Get.testMode = true;
    final firestore = FakeFirebaseFirestore();
    final activityController = ActivitiesController(firestore: firestore);
    var result =
        await activityController.deleteActivity(actvId: '2', uid: '312123232');

    expect(result, 'success');
  });
}
