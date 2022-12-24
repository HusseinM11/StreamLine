import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streamline/view/main_screens/welcome_screen.dart';

import '../controller/auth_controller.dart';
import '../controller/users_controller.dart';
import '../view/main_screens/affirmations.dart';

class Root extends GetWidget<AuthController> {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
   
    return GetX<AuthController>(
      initState: (_) async {
        Get.put<UserController>(UserController());
      },
      builder: (_) {
        if (Get.find<AuthController>().user?.uid != null) {
          return AffirmationsScreen();
        } else {
          return const WelcomeScreen();
        }
      },
    );
  }
}
