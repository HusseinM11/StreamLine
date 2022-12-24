import 'package:get/get.dart';
import 'package:streamline/auth/login.dart';
import 'package:streamline/controller/all_tasksController.dart';
import 'package:streamline/controller/todo_controller.dart';
import 'package:streamline/controller/users_controller.dart';

import '../activity_controller.dart';
import '../auth_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
    Get.lazyPut<UserController>(() => UserController(), fenix: true);
    Get.lazyPut<ActivitiesController>(() => ActivitiesController(),
        fenix: true);
    Get.lazyPut<TodosController>(() => TodosController(), fenix: true);
    Get.lazyPut<AllTasksController>(() => AllTasksController(), fenix: true);
  }
}
