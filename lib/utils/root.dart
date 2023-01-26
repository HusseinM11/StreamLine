import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streamline/view/auth/login.dart';
import 'package:streamline/view/main_screens/welcome_screen.dart';

import '../controller/auth_controller.dart';
import '../controller/users_controller.dart';


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
          return const LogIn();
        } else {
          return const WelcomeScreen();
        }
      },
    );
  }
}
