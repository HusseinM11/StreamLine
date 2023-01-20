import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  final String label;
  Function() onPressed;
  Color color;
   DialogButton({super.key, required this.label, required this.onPressed, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
     // decoration: BoxDecoration(borderRadius: BorderRadius.circular(0)),
      color: Colors.grey[100],
      child: TextButton(
          onPressed: onPressed,
          child: Text(label,
              style: TextStyle(
                fontSize: 20,
                color: color,
              ))),
    );
  }
}
