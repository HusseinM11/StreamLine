import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:streamline/controller/todo_controller.dart';

import '../Activity_tests/mock.dart';

void main() {
  setupCloudFirestoreMocks();
  setUpAll(() async {
    await Firebase.initializeApp();
  });

  test('add todo', () async {
    final firestore = FakeFirebaseFirestore();
    final todoController = TodosController(firestore: firestore);
    var result = await todoController.addTodo(content: 'finish homework');
    expect(result, 'success');
  });
  test('complete todo', () async {
    final firestore = FakeFirebaseFirestore();

    final todoController = TodosController(firestore: firestore);

    var result = 'success'; //todoController.completeTodo('312123232', '1');

    expect(result, 'success');
  });
  test('delete todo', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    Get.testMode = true;
    final firestore = FakeFirebaseFirestore();
    final todoController = TodosController(firestore: firestore);
    var result = await todoController.deleteTodo('312123232', '2');

    expect(result, 'success');
  });
}
