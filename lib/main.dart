import 'package:cron/cron.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streamline/auth/login.dart';
import 'package:streamline/auth/signup.dart';
import 'package:streamline/controller/bindings/bindings.dart';
import 'package:streamline/utils/root.dart';
import 'package:streamline/view/main_screens/home.dart';

import 'constants/firebase_constants.dart';
import 'controller/activity_controller.dart';
import 'controller/auth_controller.dart';
import 'controller/habits_controller.dart';
import 'controller/todo_controller.dart';
import 'controller/users_controller.dart';
import 'view/main_screens/affirmations.dart';
import 'view/main_screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
   
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Barlow',
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      initialBinding: InitialBinding(),
      home: Root(),
      getPages: [
        GetPage(name: '/welcome_screen', page: () => const WelcomeScreen()),
        GetPage(name: '/sign_up', page: () => const SignUp()),
        GetPage(name: '/log_in', page: () => const LogIn()),
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(
            name: '/affirmations',
            page: () => AffirmationsScreen(
                  
                )),
      ],
    );
  }
}
