
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streamline/constants/colors.dart';


import '../constants/firebase_constants.dart';
import '../model/user.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  Rxn<User> _firebaseUser = Rxn<User>();

  get user => _firebaseUser.value;

  @override
  onInit() async {
    super.onInit();
    
    _firebaseUser.bindStream(auth.authStateChanges());
  }

  void register(
      {required String email, required password, required String name}) async {
    try {
      UserCredential _authResult = await auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      //create user in database.dart
      UserModel _user = UserModel(
        id: _authResult.user!.uid,
        name: name,
        email: _authResult.user!.email,
      );
      if (await userController.createNewUser(_user)) {
        userController.user = _user;
        Get.back();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('Error', 'Password is too weak. Please try again.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.darkGrey.withOpacity(0.7),
            colorText: Colors.white);
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'Email is not available. Please try again.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.darkGrey.withOpacity(0.7),
            colorText: Colors.white);
      }
    }
  }

  void login({required String email, required password}) async {
    try {
      UserCredential _authResult = await auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      userController.user = await userController.getUser(_authResult.user!.uid);
      Get.toNamed('/affirmations');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', 'No user found with the given email.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.darkGrey.withOpacity(0.7),
            colorText: Colors.white);
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Error', 'Wrong password. Please try again.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.darkGrey.withOpacity(0.7),
            colorText: Colors.white);
      }
    }
  }

  void signOut() async {
    await auth.signOut();
    userController.clear();
    Get.offNamed('/welcome_screen');
  }
}
