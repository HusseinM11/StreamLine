// import flutter test package

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:streamline/controller/affirmation_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

//fix this error: 'Binding has not yet been initialized.\n'
//https://stackoverflow.com/questions/59172409/flutter-binding-has-not-yet-been-initialized

  test('fetch affirmation', () async {
    final affirmationController = AffirmationController();
    var result = await affirmationController.fetchAffirmation();

    expect(result, 'success');
  });
}
