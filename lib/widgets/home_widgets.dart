import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

class PlusButton extends StatelessWidget {
  Function() onPressed;
   PlusButton({
    Key? key, required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF6E50), elevation: 0),
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
