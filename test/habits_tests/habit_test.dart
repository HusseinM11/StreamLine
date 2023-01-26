import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:streamline/controller/habits_controller.dart';

import 'mock.dart';

void main() {
  setupCloudFirestoreMocks();
  setUpAll(() async {
    await Firebase.initializeApp();
  });

  final mockAuth = MockFirebaseAuth();

  test('add habit', () async {
    final firestore = FakeFirebaseFirestore();
    final habitController = HabitsController(firestore: firestore);
    var result = await habitController.addHabit(completedCount: 0, content: 'Gym', description: 'sdsds', icon: Icons.pending, isCompleted: false, priority: 'high', repeat: 2, timeAdded: Timestamp.now());

    expect(result, 'success');
  });

  test('delete habit', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    Get.testMode = true;
    final firestore = FakeFirebaseFirestore();
    final habitController = HabitsController(firestore: firestore);
    var result = await habitController.deleteHabit('22323232', '1');

    expect(result, 'success');
  });
  test('add habit to history', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    Get.testMode = true;
    final firestore = FakeFirebaseFirestore();
    final habitController = HabitsController(firestore: firestore);
    var result = await habitController.addHabitToHistory(content: 'gym', repeat: 2, timeAdded: Timestamp.now());

    expect(result, 'success');
  });

}
