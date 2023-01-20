import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:streamline/view/widgets/elevated_button.dart';

import '../../constants/colors.dart';

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
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.orange2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          )),

      // gradient: LinearGradient(colors: [Color(0xFFE65C00), Color(0xFFF9D423)]),
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

class CurrentDateWidget extends StatelessWidget {
  CurrentDateWidget({
    Key? key,
  }) : super(key: key);
  String date = DateFormat("MMMM, dd, yyyy").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(date,
            style: TextStyle(
                fontSize: 14,
                color: const Color(0xFF312B26).withOpacity(0.9),
                fontWeight: FontWeight.w300)),
        const SizedBox(width: 5),
        const Icon(FeatherIcons.calendar)
      ],
    );
  }
}
