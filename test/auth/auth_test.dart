// import flutter test package

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:streamline/controller/auth_controller.dart';
import 'mock.dart';

//fix this error: 'Binding has not yet been initialized.\n'
//https://stackoverflow.com/questions/59172409/flutter-binding-has-not-yet-been-initialized

void main() {
  
  setupFirebaseAuthMocks();
  setUpAll(() async {
    await Firebase.initializeApp();
  });
final mockAuth = MockFirebaseAuth();
  // test the register function inside my authcontroller
  test('register', () async {
  final auth = AuthController(auth: mockAuth);
   
    var result = await auth.register(
        email: 'hussein@gmail.com', password: '123456', name: 'hussein');

    expect(result, 'Success');
   
  });
  test('weak password', () async {
  final auth = AuthController(auth: mockAuth);
  
  expect( await auth.register(
        email: 'hussein@gmail.com', password: '123456', name: 'hussein'), 'Success');
  });

  test('log in', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    Get.testMode = true;
  final auth = AuthController(auth: mockAuth);
    var result = await auth.login(
        email: 'hussein@gmail.com', password: '123456');

    expect(result, 'Success');
  });
  //test for the signout method
  test('sign out', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    Get.testMode = true;
  final auth = AuthController(auth: mockAuth);
    var result = await auth.signOut();
    expect(result, 'Success');
  });
}
