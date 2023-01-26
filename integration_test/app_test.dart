import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:streamline/constants/firebase_constants.dart';
import 'package:streamline/controller/todo_controller.dart';
import 'package:streamline/main.dart';

Future<void> addDelay(int ms) async {
  await Future<void>.delayed(Duration(milliseconds: ms));
}

@Timeout(Duration(hours: 10))
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    final timeBasedEmail =
        DateTime.now().microsecondsSinceEpoch.toString() + 'hussein@test.com';
    //time based password
    final timeBasedPassword =
        DateTime.now().microsecondsSinceEpoch.toString() + '123456';
    //time based name
    final timeBasedName =
        DateTime.now().microsecondsSinceEpoch.toString() + 'integration';

    

    testWidgets('Sign up and login test', (tester) async {
      await Firebase.initializeApp(); // previous code
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      await addDelay(10000);
      // tap the value key register-btn
      await tester.tap(find.byKey(const ValueKey('register-btn')));
      await tester.pumpAndSettle();
      //tap the name-field and enter name
      await tester.enterText(
          find.byKey(const ValueKey('name-field')), timeBasedName);
      await tester.enterText(
          find.byKey(const ValueKey('email-field')), timeBasedEmail);
      await tester.enterText(
          find.byKey(const ValueKey('password-field')), timeBasedPassword);
      await tester.enterText(
          find.byKey(const ValueKey('confirmPassword-field')),
          timeBasedPassword);
      await tester.tap(find.byKey(const ValueKey('submit-btn')));
  
     await addDelay(10000);
      await tester.pumpAndSettle();
  
      await tester.enterText(
          find.byKey(const ValueKey('emailLogin-field')), timeBasedEmail);
      //tap on the password field and enter the password
      await tester.enterText(
          find.byKey(const ValueKey('passwordLogin-field')), timeBasedPassword);
      //tap on the loginSubmit-btn button
      await tester.tap(find.byKey(const ValueKey('submitLogin-btn')));
      await tester.pumpAndSettle();
      await addDelay(10000);
     
      expect(find.text('This is your daily food for thought:'), findsOneWidget);

      tester.printToConsole('Signed up and Signed in successfully');
    });
    testWidgets('Add todo', (tester) async {
      
      await Firebase.initializeApp(); // previous code
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      await addDelay(10000);
      // tap the value key register-btn
      await tester.tap(find.byKey(const ValueKey('register-btn')));
      await tester.pumpAndSettle();
      //tap the name-field and enter name
      await tester.enterText(
          find.byKey(const ValueKey('name-field')), timeBasedName);
      await tester.enterText(
          find.byKey(const ValueKey('email-field')), timeBasedEmail);
      await tester.enterText(
          find.byKey(const ValueKey('password-field')), timeBasedPassword);
      await tester.enterText(
          find.byKey(const ValueKey('confirmPassword-field')),
          timeBasedPassword);
      await tester.tap(find.byKey(const ValueKey('submit-btn')));
  
     await addDelay(10000);
      await tester.pumpAndSettle();
  
      await tester.enterText(
          find.byKey(const ValueKey('emailLogin-field')), timeBasedEmail);
      //tap on the password field and enter the password
      await tester.enterText(
          find.byKey(const ValueKey('passwordLogin-field')), timeBasedPassword);
      //tap on the loginSubmit-btn button
      await tester.tap(find.byKey(const ValueKey('submitLogin-btn')));
      await tester.pumpAndSettle();
      await addDelay(10000);
      //tap the ready-btn button
      await tester.tap(find.byKey(const ValueKey('ready-btn')));
      await tester.pumpAndSettle();
      await addDelay(3000);
      //tap the addTodo-btn button
      await tester.tap(find.byKey(const ValueKey('addTodo-btn')));
      await tester.pumpAndSettle();
      await addDelay(2000);
      // tap the text todo-field and enter todo
      int initialTodoCount = todosController.todos.length;
      await tester.enterText(
          find.byKey(const ValueKey('todo-field')), 'integration test todo');
          //tap the addSubmit-button button
      await tester.tap(find.byKey(const ValueKey('addSubmit-btn')));
      await tester.pumpAndSettle();
      await addDelay(2000);
      
      expect(todosController.todos.length, initialTodoCount + 1);

      tester.printToConsole('To do Added`');
    });
   

     
  });
}
