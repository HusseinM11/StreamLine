import 'package:flutter/material.dart';


class MyMessageHandler {
  static void showSnackBar(var _scaffoldKey, String message) {
    _scaffoldKey.currentState!.hideCurrentSnackBar();
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Color(0xFF654236),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        )));
  }
}