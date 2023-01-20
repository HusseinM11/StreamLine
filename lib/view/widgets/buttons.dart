import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class RoundedTextButton extends StatelessWidget {
  String label;
  Function() onPressed;
  RoundedTextButton({Key? key, required this.label, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            backgroundColor: AppColors.orange2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 5),
          child: Text(label,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 30)),
        ));
  }
}