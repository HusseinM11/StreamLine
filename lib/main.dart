import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:streamline/auth/login.dart';
import 'package:streamline/auth/signup.dart';
import 'package:streamline/main_screens/home.dart';

import 'main_screens/affirmations.dart';
import 'main_screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Barlow',
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/welcome_screen',
      routes: {
        '/welcome_screen': (context) => const WelcomeScreen(),
        '/sign_up': (context) => const SignUp(),
        '/log_in': (context) => const LogIn(),
        '/home': (context) => const HomeScreen(),
        '/affirmations': (context) => AffirmationsScreen(
              documentId: FirebaseAuth.instance.currentUser!.uid,
            ),
      },
    );
  }
}
