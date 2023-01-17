import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:streamline/constants/colors.dart';

import '../controller/habits_controller.dart';
import '../model/habit.dart';

class HabitCircle extends StatelessWidget {
  final String uid;
  final HabitModel habit;

  HabitCircle({super.key, required this.uid, required this.habit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: AnimatedContainer(
              curve: Curves.easeOut,
              duration: Duration(milliseconds: 1000),
              constraints: const BoxConstraints.expand(),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    habit.isCompleted ? AppColors.orange2 : Colors.transparent,
              ),
              child: Stack(alignment: AlignmentDirectional.center, children: [
                CircularPercentIndicator(
                  circularStrokeCap: CircularStrokeCap.round,
                  animation: true,
                  animateFromLastPercent: true,
                  animationDuration: 500,
                  lineWidth: 10,
                  backgroundColor: AppColors.orange2.withOpacity(0.3),
                  progressColor: AppColors.orange2,
                  percent: habit.completedCount / habit.repeatDaily,
                  radius: 80,
                ),
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Icon(habit.icon,
                        size: 75,
                        color: !habit.isCompleted
                            ? AppColors.darkGrey
                            : Colors.white),
                    habit.streak != 0
                        ? Padding(
                          padding: const EdgeInsets.only( bottom: 16.0),
                          child: Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(habit.streak.toString(),
                                    style: TextStyle(
                                        color: habit.isCompleted
                                            ? Colors.white
                                            : AppColors.darkGrey,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700)),
                                // a flame streak icon
                                Icon(Icons.whatshot,
                                    color: habit.isCompleted
                                        ? Colors.white
                                        : AppColors.darkGrey,
                                    size: 20)
                              ],
                            ),
                          ),
                        )
                        : Container(),
                        
                  ],
                ),
              ])),
        ),
        SizedBox(height: 8),
        Text(habit.content,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: AppColors.darkGrey,
                fontSize: 18,
                fontWeight: FontWeight.w700))
      ],
    );
  }
}
