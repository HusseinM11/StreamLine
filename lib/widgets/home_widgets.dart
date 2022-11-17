import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

class HabitTile extends StatelessWidget {
  final String habitName;
  final Function() onPressed;
  final int timeSpent;
  final int timeGoal;
  final bool habitStarted;

  const HabitTile(
      {Key? key,
      required this.habitName,
      required this.onPressed,
      required this.timeSpent,
      required this.timeGoal,
      required this.habitStarted})
      : super(
          key: key,
        );

  //convert seconds to minutes
  String formatToMinSec(int totalSeconds) {
    String secs = (totalSeconds % 60).toString();
    String mins = (totalSeconds / 60).toStringAsFixed(5);

    if (secs.length == 1) {
      secs = '0' + secs;
    }

    if (mins[1] == '.') {
      mins = mins.substring(0, 1);
    }

    return mins + ':' + secs;
  }

  // calculate percentage
  double percentCompleted() {
    return timeSpent / (timeGoal * 60);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
          width: 130,
          height: 10,
          decoration: BoxDecoration(
              color: Color(0xFFFF6E50),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      habitName,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                    SizedBox(height: 5),
                    Text(
                      formatToMinSec(timeSpent) + ' / ' + timeGoal.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 14),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        height: 60,
                        width: 60,
                        child: Stack(
                          children: [
                            CircularPercentIndicator(
                                progressColor: percentCompleted() > 0.5
                                    ? Colors.green
                                    : Color(0xFF312B26),
                                percent: percentCompleted(),
                                radius: 30,
                                lineWidth: 5,
                                backgroundColor: Colors.white),
                            Center(
                              child: IconButton(
                                onPressed: onPressed,
                                icon: Icon(
                                    habitStarted
                                        ? FeatherIcons.pause
                                        : FeatherIcons.play,
                                    size: 24,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

class DailyStatsTab extends StatelessWidget {
  final String label;
  final int completed;
  const DailyStatsTab({
    Key? key, required this.label , required this.completed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(completed.toString(), style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
        Text(label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
      ],
    );
  }
}

