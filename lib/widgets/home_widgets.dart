import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:streamline/widgets/elevated_button.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

class PlusButton extends StatelessWidget {
  Function() onPressed;
  PlusButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyElevatedButton(
      borderRadius: BorderRadius.circular(5),
      gradient: LinearGradient(colors: [Color(0xFFE65C00), Color(0xFFF9D423)]),
      onPressed: onPressed,
      child: const Icon(FeatherIcons.plus, size: 20),
    );
  }
}

class DailyStatsTab extends StatelessWidget {
  final String label;
  final int completed;
  const DailyStatsTab({Key? key, required this.label, required this.completed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(completed.toString(),
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
        Text(label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
      ],
    );
  }
}
