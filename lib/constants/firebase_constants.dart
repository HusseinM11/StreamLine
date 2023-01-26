import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import '../controller/activity_controller.dart';
import '../controller/auth_controller.dart';
import '../controller/todo_controller.dart';
import '../controller/users_controller.dart';

AuthController authController = AuthController.instance;
final todosController = Get.put(TodosController(firestore: firebaseFirestore));
final userController = Get.put(UserController());
final activitiesController = Get.put(ActivitiesController(firestore: FirebaseFirestore.instance));
final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
