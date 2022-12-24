import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:streamline/constants/colors.dart';

import '../controller/habits_controller.dart';
import '../model/habit.dart';

class HabitCircle extends StatelessWidget {
  final String uid;
  final HabitModel habit;

  HabitCircle({
    super.key,
    required this.uid,
    required this.habit
  });

  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [
          Flexible(
            child: Container(
                constraints: const BoxConstraints.expand(),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: habit.isCompleted ? AppColors.orange2 : Colors.transparent,
                    border: Border.all(
                        color:
                            !habit.isCompleted ? AppColors.orange2 : Colors.transparent,
                        width: 7)),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      Icon(habit.icon,
                          size: 60,
                          /* color: !habitDone!
                                ? AppColors.darkGrey
                                : habitDone!
                                    ? Colors.white
                                    : Colors.white), */
                          color:
                              !habit.isCompleted ? AppColors.darkGrey : Colors.white),
                      const SizedBox(height: 10),
                      Text(
                          habit.completedCount.toString() +
                              ' / ' +
                              habit.repeatDaily.toString(),
                          style: TextStyle(
                              color:
                                  habit.isCompleted ? Colors.white : AppColors.darkGrey,
                              fontSize: 20,
                              fontWeight: FontWeight.w700))
                    ],
                  ),
                )),
          ),
          const SizedBox(height: 5),
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
/* 
Text( habitCount.toString(),
                        style: TextStyle(
                            color:
                                habitDone! ? Colors.white : AppColors.darkGrey,
                            fontSize: 24,
                            fontWeight: FontWeight.w700)), */