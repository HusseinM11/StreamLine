import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:streamline/constants/firebase_constants.dart';
import 'package:streamline/view/auth/login.dart';
import 'package:streamline/controller/affirmation_controller.dart';
import 'package:streamline/controller/all_tasksController.dart';
import 'package:streamline/controller/todo_controller.dart';
import 'package:streamline/controller/users_controller.dart';

import '../activity_controller.dart';
import '../auth_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(auth: FirebaseAuth.instance), fenix: true);
    Get.lazyPut<UserController>(() => UserController(), fenix: true);
    Get.lazyPut<ActivitiesController>(() => ActivitiesController(firestore: firebaseFirestore),
        fenix: true);
    Get.lazyPut<TodosController>(() => TodosController(firestore: firebaseFirestore), fenix: true);
    Get.lazyPut<AllTasksController>(() => AllTasksController(), fenix: true);
    Get.lazyPut<AffirmationController>(() => AffirmationController(), fenix: true);
  }
}
