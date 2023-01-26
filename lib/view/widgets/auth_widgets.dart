import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  String label;
  Function() onPressed;
  AuthButton({Key? key, required this.label, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
       
        onPressed: onPressed,
        // ignore: sort_child_properties_last
        child: Text(label,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 20),
          backgroundColor: const Color(0xFF312B26),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // <-- Radius
          ),
        ),
      ),
    );
  }
}

var textFormDecoration = InputDecoration(
  errorStyle: TextStyle(fontSize: 14, color: Colors.white, ),
  labelText: 'Full Name',
  hintText: 'Enter your full name',
  labelStyle: TextStyle(color: Color(0xFFFDEAC1)),
  hintStyle: TextStyle(color: Color(0xFFFDEAC1)),
  icon: Icon(Icons.person, color: Color(0xFFFDEAC1)),
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFFFDEAC1), width: 1),
      borderRadius: BorderRadius.circular(10)),
  focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFFFDEAC1), width: 2),
      borderRadius: BorderRadius.circular(10)),
);

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^([a-zA-Z0-9]+)([\-\_\.]*)([a-zA-Z0-9]*)([@])([a-zA-Z0-9]{2,})([\.][a-zA-Z]{2,3})$')
        .hasMatch(this);
  }
}
