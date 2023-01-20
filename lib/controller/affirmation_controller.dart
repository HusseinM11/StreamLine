import 'dart:math';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AffirmationController extends GetxController {
  String _affirmation = '';
  bool isLoading = true;

  String get affirmation => _affirmation;
  @override
  void onInit() {
    fetchAffirmation();
    super.onInit();
  }

  Future<void> fetchAffirmation() async {
    try {
      final response = await rootBundle.loadString(
          '/Users/flyostrich/StreamLine/streamline/assets/data/affirmations.json');
      final data = jsonDecode(response);
      // Select a random affirmation from json file
      int index = Random().nextInt(data.length);
      _affirmation = data[index]["Quote"];
      isLoading = false;
      update();
    } catch (e) {
      print(e);
    }
  }
}
